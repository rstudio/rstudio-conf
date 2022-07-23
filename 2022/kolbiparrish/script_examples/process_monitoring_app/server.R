server <- function(input, output, session) {
  
  # Values that will change throughout the session
  values <- reactiveValues(refresh_time = Sys.time(), load_prod_history_error_log = 0, load_dev_history_error_log = 0)
  
  # Dev and Prod titles--------------
  output$prod_title <- renderUI({
    HTML(paste(h4("PROD Errors", paste(error_days_to_read, collapse = " to "))))
  })# end prod_title
  
  output$dev_title <- renderUI({
    HTML(paste(h4("DEV Errors", paste(error_days_to_read, collapse = " to "))))
  })# end prod_title
  
  output$prod_title_history_modal <- renderUI({
    HTML(paste(h2("PROD (last 30d)")))
  })# end prod_title
  
  output$dev_title_history_modal <- renderUI({
    HTML(paste(h2("DEV (last 30d)")))
  })# end prod_title
  
  # Timestamp headers and text------------
  output$summary_refresh_time <- renderUI({
    HTML(paste("<i> Last refreshed:", format(values$refresh_time, "%Y-%m-%d %I:%M %p")))  
  })# end plot_refresh_time  
  
  # Prod Logs readin----------
  prod_flag_log <- reactivePoll(300000, session,
                                # This function returns the time that PROD_FLAG_FILE was last modified
                                checkFunc = function() {
                                  if (file.exists(PROD_FLAG_FILE))
                                    file.info(PROD_FLAG_FILE)$mtime[1]
                                  else
                                    ""
                                },
                                # This function returns the content of PROD_FLAG_FILE
                                valueFunc = function() {
                                  values$refresh_time <- Sys.time()
                                  prod_flag <- fread(PROD_FLAG_FILE, sep = ",") %>%
                                    filter(timestamp >= Sys.Date() - 30) %>%
                                    mutate(timestamp = as.POSIXct(timestamp)) %>%
                                    as.data.table()
                                  return(prod_flag)
                                }
  )# end prod_flag_log
  
  # Dev Logs readin-------------
  dev_flag_log <- reactivePoll(300000, session,
                               # This function returns the time that DEV_FLAG_FILE was last modified
                               checkFunc = function() {
                                 if (file.exists(DEV_FLAG_FILE))
                                   file.info(DEV_FLAG_FILE)$mtime[1]
                                 else
                                   ""
                               },
                               # This function returns the content of DEV_FLAG_FILE
                               valueFunc = function() {
                                 values$refresh_time <- Sys.time()
                                 dev_flag <- fread(DEV_FLAG_FILE, sep = ",") %>%
                                   filter(timestamp >= Sys.Date() - 30) %>%
                                   mutate(timestamp = as.POSIXct(timestamp)) %>%
                                   as.data.table()
                                 return(dev_flag)
                               }
  )# end dev_flag_log
  
  prod_error_log <- reactivePoll(300000, session,
                                 # This function returns the time that the most recent dev error log was last modified
                                 checkFunc = function() {
                                   if (file.exists(most_recent_prod_error_path))
                                     file.info(most_recent_prod_error_path)$mtime[1]
                                   else
                                     ""
                                 },
                                 # This function returns the content of last 2 days worth of error logs
                                 valueFunc = function() {
                                   values$refresh_time <- Sys.time()
                                   error_log <- bind_rows(lapply(error_days_to_read_string, function(dt) {
                                     read_logs(paste0(prod_error_file_path, "data_processing_error_info_log_connect_", dt, ".log"))
                                   }))
                                   return(error_log)
                                 }
  )# end prod_error_log
  
  dev_error_log <- reactivePoll(300000, session,
                                # This function returns the time that the most recent dev error log was last modified
                                checkFunc = function() {
                                  if (file.exists(most_recent_dev_error_path))
                                    file.info(most_recent_dev_error_path)$mtime[1]
                                  else
                                    ""
                                },
                                # This function returns the content of last 2 days worth of error logs
                                valueFunc = function() {
                                  values$refresh_time <- Sys.time()
                                  error_log <- bind_rows(lapply(error_days_to_read_string, function(dt) {
                                    read_logs(paste0(dev_error_file_path, "data_processing_error_info_log_connect_", dt, ".log"))
                                  }))
                                  return(error_log)
                                }
  )# end dev_error_log
  
  # Prod datasets------------
  prod_flag_most_recent_data <- reactive({
    prod_flag_log() %>%
      group_by(process, id) %>%
      filter(timestamp == max(timestamp, na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(timestamp_string = format(timestamp, "%Y-%m-%d %I:%M %p"))
  })# end prod_flag_most_recent_data

  prod_error_history_data <- eventReactive(values$load_prod_history_error_log, {
    error_log <- bind_rows(lapply(errors_days_to_read_history_string, function(dt) {
      read_logs(paste0(prod_error_file_path, "data_processing_error_info_log_connect_", dt, ".log"))
    }))
    only_errors <- error_log %>%
      filter(log_lvl == "ERROR") %>%
      select(all_of(error_cols_to_view))
    
    return(only_errors)
    
  })# end prod_error_history_data
  
  # Info table for processes-----
  prod_only_info <- reactive({
    info_tbl(df = prod_error_log())
  })
  
  # Dev datasets------------
  dev_flag_most_recent_data <- reactive({
    dev_flag_log() %>%
      group_by(process, id) %>%
      filter(timestamp == max(timestamp, na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(timestamp_string = format(timestamp, "%Y-%m-%d %I:%M %p"))
  })# end prod_flag_most_recent_data
  
  dev_error_history_data <- eventReactive(values$load_dev_history_error_log, {
    error_log <- bind_rows(lapply(errors_days_to_read_history_string, function(dt) {
      read_logs(paste0(dev_error_file_path, "data_processing_error_info_log_connect_", dt, ".log"))
    }))
    only_errors <- error_log %>%
      filter(log_lvl == "ERROR") %>%
      select(all_of(error_cols_to_view))
    
    return(only_errors)
    
  })# end dev_error_history_data
  
  # Dev info processes----------
  dev_only_info <- reactive({
    info_tbl(df = dev_error_log())
  })
  
  # Prod datatables--------------
  output$prod_process_summary_tbl <- DT::renderDataTable({
    DT::datatable(data = prod_flag_log(),
                  rownames = FALSE,
                  options = list(order = list(list(3, 'desc')))) %>%
      formatDate(columns = 4,
                 method = "toLocaleString")
  })
  
  output$prod_error_log_tbl <- DT::renderDataTable({
    prod_only_error <- prod_error_log() %>%
      filter(log_lvl == "ERROR") %>%
      select(all_of(error_cols_to_view))
    
    DT::datatable(data = prod_only_error,
                  rownames = FALSE,
                  options = list(scrollX = T,
                                 order = list(list(0, 'desc')))) %>%
      formatDate(columns = 1,
                 method = "toLocaleString")
  })
  
  output$prod_error_history_tbl <- DT::renderDataTable({
    DT::datatable(data = prod_error_history_data(),
                  rownames = FALSE,
                  options = list(scrollX = T,
                                 order = list(list(0, 'desc')))) %>%
      formatDate(columns = 1,
                 method = "toLocaleString")
  })# end output$prod_error_history_tbl
  
  # Process Info table
  output$prod_info_log_tbl_process <- DT::renderDataTable({
    format_info_tbl(df = prod_only_info(), script_name = "rmd_connect_shiny_pres_example_script.Rmd")
  })# end output
  
  # Dev datatables-------------
  output$dev_error_log_tbl <- DT::renderDataTable({
    dev_only_error <- dev_error_log() %>%
      filter(log_lvl == "ERROR") %>%
      select(all_of(error_cols_to_view))
    
    DT::datatable(data = dev_only_error,
                  rownames = FALSE,
                  options = list(scrollX = T,
                                 order = list(list(0, 'desc')))) %>%
      formatDate(columns = 1,
                 method = "toLocaleString")
  })  
  
  # Process Info table
  output$dev_info_log_tbl_process <- DT::renderDataTable({
    format_info_tbl(df = dev_only_info(), script_name = "rmd_connect_shiny_pres_example_script.Rmd")
  })# end output
  
  
  # Full history of process flags observeEvent----------
  observeEvent(input$full_process_flag_history, {
    showModal(   
      modalDialog(
        size = "l",
        title = h3("Full History"),
        fluidRow(
          column(width = 6,
                htmlOutput("prod_title_history_modal")),
          column(width = 6,
                htmlOutput("dev_title_history_modal"))        
        ),
        br(),
        fluidRow(
          column(width = 6,
                DT::dataTableOutput("prod_process_summary_tbl")),
          column(width = 6,
                DT::dataTableOutput("dev_process_summary_tbl"))        
        )
    ))
  })# end observeEvent
  
  
  # Full history of error flags observeEvent (dev and prod)------------
  observeEvent(input$prod_error_history_btn,{
    values$load_prod_history_error_log <- values$load_prod_history_error_log + 1
    showModal(   
      modalDialog(
        size = "l",
        title = h3(paste0("Prod Error History (", error_days_to_read_history, " d)")),
        fluidRow(
          DT::dataTableOutput("prod_error_history_tbl")
        )# end fluidRow
      )# end modalDialog
    )# end showModal
  })# end observeEvent
  
  observeEvent(input$dev_error_history_btn,{
    values$load_dev_history_error_log <- values$load_dev_history_error_log + 1
    showModal(
      modalDialog(
        size = "l",
        title = h3(paste0("Dev Error History (", error_days_to_read_history, " d)")),
        fluidRow(
          DT::dataTableOutput("dev_error_history_tbl")
        )# end fluidRow
      )# end modalDialog
    )# end showModal
  })# end observeEvent
  
  # Process plot graph-----
  output$most_recent_data_process_graph <- renderPlotly({
    process_plot()
  })# end renderPlotly
  
  
  # Process plot graph function---------------
  process_plot <- reactive({
    
    # Getting all of the distinct processes for graphing one rectangle per process
    all_processes_prod <- prod_flag_most_recent_data() %>%
      select(process) %>%
      distinct()
    
    all_processes_dev <- dev_flag_most_recent_data() %>%
      select(process) %>%
      distinct()
    
    # Configuring layout options
    fig <- plot_ly(height = PROCESS_PLOT_HEIGHT)
    font_title <- list(size = 15)
    title_text <- list(text = paste0("<b>", "Most Recent Processes (x marker means currently running)", "</b>"), x = 0.05)
    axis_title <- list(size = 14)
    axis_text <- list(size = 12)
    legend_settings <- list(
      font = list(
        family = "sans-serif",
        size = 12,
        color = "#000"),
      bgcolor = "#E2E2E2",
      bordercolor = "#FFFFFF",
      borderwidth = 2,
      xanchor = "center", 
      x = 100,
      yanchor = "top",
      y = 1)
    
    # Prod Graph
    for(proc in 1:nrow(all_processes_prod)){
      process_name <- all_processes_prod$process[proc]
      process <- prod_flag_most_recent_data() %>% 
        filter(process == process_name & str_detect(id, "_start|_end")) %>%
        arrange(timestamp)
      
      # If a process is in the middle of running, need to not include the end of the last run
      if(which(str_detect(process$id, "_start")) > which(str_detect(process$id, "_end"))){
        process <- process %>%
          filter(str_detect(id, "_start"))
        
        fig <- add_trace(fig,
                         data=process,
                         x=c(process$timestamp[1]),
                         y=paste0('PROD_', process_name),
                         type = "scatter",
                         mode = "markers",
                         hovertemplate = paste('<b>Process</b>: %{y}<br>',
                                               'Start time: %{x}'),
                         marker = list(color = "#FF0000", width = 15, symbol = "x"),
                         name = paste0("PROD_", process_name))  
        
      }# end if
      else{
        fig <- add_trace(fig,
                         data=process,
                         x=c(process$timestamp[1], process$timestamp[2]),
                         y=paste0('PROD_', process_name),
                         type = "scatter",
                         mode = "lines+markers",
                         hovertemplate = paste('<b>Process</b>: %{y}<br>',
                                               '%{text}'),
                         text = paste('Start time:', process$timestamp_string[1], "\n",
                                      'End time:', process$timestamp_string[2], "\n",
                                      'Run time:', paste(round(difftime(process$timestamp[2], process$timestamp[1], unit = 'mins'), 2), "minutes")),
                         line = list(color = "#FF0000", width = 15),
                         name = paste0("PROD_", process_name))  
      }#end else
    }# end for loop
    
    # Dev Graph
    for(proc in 1:nrow(all_processes_dev)){
      process_name <- all_processes_dev$process[proc]
      process <- dev_flag_most_recent_data() %>% 
        filter(process == process_name & str_detect(id, "_start|_end")) %>%
        arrange(timestamp)
      
      # If a process is in the middle of running, need to not include the end of the last run
      if(which(str_detect(process$id, "_start")) > which(str_detect(process$id, "_end"))){
        process <- process %>%
          filter(str_detect(id, "_start"))
        
        fig <- add_trace(fig,
                         data=process,
                         x=c(process$timestamp[1]),
                         y=paste0('DEV_', process_name),
                         type = "scatter",
                         mode = "markers",
                         hovertemplate = paste('<b>Process</b>: %{y}<br>',
                                               'Start time: %{x}'),
                         marker = list(color = "#0000ff", width = 15, symbol = "x"),
                         name = paste0("DEV_", process_name))  
        
      }# end if
      else{
        fig <- add_trace(fig,
                         data=process,
                         x=c(process$timestamp[1], process$timestamp[2]),
                         y=paste0('DEV_', process_name),
                         type = "scatter",
                         mode = "lines+markers",
                         hovertemplate = paste('<b>Process</b>: %{y}<br>',
                                               '%{text}'),
                         text = paste('Start time:', process$timestamp_string[1], "\n",
                                      'End time:', process$timestamp_string[2], "\n",
                                      'Run time:', paste(round(difftime(process$timestamp[2], process$timestamp[1], unit = 'mins'), 2), "minutes")),
                         line = list(color = "#0000ff", width = 15),
                         name = paste0("DEV_", process_name))  
      }#end else 
    }# end for
    
    xaxis_settings <- list(title = "Timestamp",
                           zeroline = TRUE,
                           showline = TRUE,
                           mirror = "ticks",
                           linecolor = toRGB("black"),
                           linewidth = 1,
                           rangeselector = list(
                             x = 0.70,
                             activecolor = toRGB("green"),
                             buttons = list(
                               list(
                                 count = 2,
                                 label = "2 days",
                                 step = "day",
                                 stepmode = "backward"),
                               list(count = 1,
                                    label = "1 week",
                                    step = "week",
                                    stepmode = "backward"),
                               list(step = "all",
                                    label = "show all processes"))),
                           rangeslider = list(type = "date",
                                              thickness = 0.10),
                           tickangle = -45)
    
    yaxis_settings <- list(title = "Process",
                           zeroline = TRUE,
                           showline = TRUE,
                           mirror = "ticks",
                           linecolor = toRGB("black"),
                           linewidth = 1, 
                           rangemode = 'tozero',
                           categoryorder = 'array',
                           categoryarray = process_order_for_plot)
    
    fig <- fig %>% layout(title = title_text,
                          font = font_title,
                          xaxis = xaxis_settings,
                          yaxis = yaxis_settings,
                          margin = list(t = 50),
                          legend = legend_settings)
    
    return(fig)
  })
  
}# end server