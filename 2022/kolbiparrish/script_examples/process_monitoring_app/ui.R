ui <- fluidPage(theme = shinytheme("yeti"),
                useShinyjs(),
                tags$head(tags$style(HTML('
                            .modal-lg {
                            width: 1200px;
                            }
                            '))),
                tags$head(tags$style(".download_styling{
                                        background-color:#292827; 
                                        padding:8px; 
                                        font-size:80%;
                                        color:white}")),
                tags$head(tags$style(".red_notification{
                                        background-color: #8B0000;
                                        padding:8px;
                                        font-size:80%;
                                        color:white}")),
                navbarPage(               
                  title = "Data Process Monitoring",
                  id="tabs",
                  tabPanel("Summary",
                           tabsetPanel(id = "ts_summary",
                                       tabPanel("Processes",
                                                br(),
                                                fluidRow(
                                                  column(width = 6,
                                                         htmlOutput("summary_refresh_time"))
                                                ),
                                                br(),
                                                fluidRow(
                                                  column(width = 10,
                                                         actionButton("full_process_flag_history", "View full process log history"))),
                                                #   column(width = 2,
                                                #          dropdown(inputId = "process_alert_notification",
                                                #                   icon = icon("exclamation-triangle"),
                                                #                   circle = FALSE,
                                                #                   status = "warning",
                                                #                   label = "Alert: 0",
                                                #                   fluidRow(DT::dataTableOutput("process_alert_tbl")),
                                                #                   br(),
                                                #                   fluidRow(actionButton(inputId = "resolve_process_alert_btn",
                                                #                                         label = "Resolve selected item",
                                                #                                         class = "download_styling"))))
                                                # ),
                                                br(),
                                                fluidRow(
                                                  plotlyOutput("most_recent_data_process_graph")
                                                ),
                                                br(),
                                                br(),
                                                br(),
                                                br(),
                                                br(),
                                                br(),
                                                fluidRow(
                                                  column(width = 6,
                                                         panel(
                                                           heading = 
                                                             fluidRow(
                                                               column(width = 8,
                                                                      htmlOutput("prod_title")),
                                                               column(width = 4,
                                                                      actionButton("prod_error_history_btn", "View error history"))
                                                             ), # end fluidRow
                                                           DT::dataTableOutput("prod_error_log_tbl")
                                                         )# end panel
                                                  ), #end column
                                                  column(width = 6,
                                                         panel(
                                                           heading = 
                                                             fluidRow(
                                                               column(width = 8,
                                                                      htmlOutput("dev_title")),
                                                               column(width = 4,
                                                                      actionButton("dev_error_history_btn", "View error history"))
                                                             ), # end fluidRow
                                                           DT::dataTableOutput("dev_error_log_tbl")
                                                         )# end panel
                                                  ) # end column
                                                )#end fluidRow
                                       )# end tabPanel
                  )),#end Summary tabPanel
                  tabPanel("Process #1",
                           h1("Dev"),
                           br(),
                           fluidRow(
                             DT::dataTableOutput("dev_info_log_tbl_process")
                           ),
                           br(),
                           h1("Prod"),
                           br(),
                           fluidRow(
                             DT::dataTableOutput("prod_info_log_tbl_process")
                           )
                  )# end tabPanel
                ) #End navbarPage
) # End UI fluidPage