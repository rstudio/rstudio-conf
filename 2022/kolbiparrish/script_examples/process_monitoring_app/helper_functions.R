# Creates an Info Table Using Fields Available in the Log File
info_tbl <- function(df){
  data_tbl <- df %>%
    filter(log_lvl == "INFO") %>%
    select(all_of(error_cols_to_view)) %>%
    mutate(script_chunk = str_remove(script_chunk, " chunk"), # Cleaning up the script_chunk field
           date = as.Date(timestamp, format="%Y-%m-%d"),
           temp_time = strptime(timestamp, format = "%Y-%m-%dT%H:%M:%S%z"),
           time_type = case_when(
             grepl("Start of", log_msg, ignore.case = TRUE) ~ "start_time",
             grepl("End of", log_msg, ignore.case = TRUE) ~ "end_time_temp", 
             TRUE ~ NA_character_
           )
    ) %>%
    arrange(desc(temp_time), script, script_chunk) %>% # Arrange and distinct used to keep the most recent log for each script / script chunk combo
    distinct(script, script_chunk, time_type, .keep_all = TRUE) %>% 
    arrange(temp_time, script, script_chunk) %>% # This sort arranges the log entries so the earliest entry is on top and the most recent entry is on the bottom
    select(date, script, script_chunk, temp_time, time_type)
  
  start <- data_tbl %>%
    filter(time_type == "start_time") %>%
    rename(start_time = temp_time) %>%
    select(-c("time_type"))
  
  end <- data_tbl %>%
    filter(time_type == "end_time_temp") %>%
    rename(end_time_temp = temp_time) %>%
    select(-c("time_type", "date"))
  
  all <- start %>%
    left_join(end, by = c("script" = "script", "script_chunk" = "script_chunk")) %>%
    mutate(run_time_mins_temp = round(difftime(end_time_temp, start_time, units = "mins"),0),
           run_time_mins = case_when(run_time_mins_temp >= 0 ~ run_time_mins_temp), # Run time will be a negative number for sections of code that have started running, but haven't finished running yet since the end timestamp will be from the most recent completed run - make negative numbers null
           end_time = case_when(run_time_mins_temp >= 0 ~ end_time_temp) # If run time is negative for the reason mentioned above, end time will be a value that is not associated with the current run - make this value null in those instances
    ) %>%
    select(date, script, script_chunk, start_time, end_time, run_time_mins)
}

# Formats the Info Table for UI Display (by script)
format_info_tbl <- function(df, script_name){
  data_tbl <- df %>%
    filter(script == script_name) 
  
  DT::datatable(data = data_tbl,
                rownames = FALSE,
                options = list(scrollX = T,
                               order = list(list(1, 'asc'), list(4, 'asc')))) %>%
    formatDate(columns = c(1),
               method = "toLocaleDateString") %>%
    formatDate(columns = c(4,5),
               method = "toLocaleTimeString")
}

# Function to return various input choices if the choices include an "All" selection
get_choices_list <- function(all_choices_string, choices_list, input_list){
  if (all_choices_string %in% input_list){
    remove_all_choices_string <- choices_list[!choices_list %in% all_choices_string]
    return(c(NA, remove_all_choices_string))
  }
  else{
    return(choices_list[choices_list %in% input_list])
  }
}