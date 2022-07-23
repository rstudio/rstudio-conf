library(tidyverse)
library(data.table)
library(shinythemes)
library(DT)
library(shiny)
library(loggit)
library(plotly)
library(readxl)
library(shinyjs)
library(shinyWidgets)
library(shinyBS)
source("helper_functions.R")

# Add write paths for file logs here
DEV_PATH <- "/mnt/projects/connect-izb/rmd_generate_dev/sandbox/logs"
PROD_PATH <- "/mnt/projects/connect-izb/rmd_generate/sandbox/logs"

# Date used in creation of daily log file
DATE_TO_PRINT <- format(Sys.Date(), "%Y%m%d")

# Setting up all relevant dev and prod file path constants--------
PROD_FLAG_FILE <- paste0(PROD_PATH, "/connect/process_flag_logs/flag_log.csv")
DEV_FLAG_FILE <- paste0(DEV_PATH, "/connect/process_flag_logs/flag_log.csv")

prod_error_file_path <- paste0(PROD_PATH, "/connect/error_warning_info_logs/")
dev_error_file_path <- paste0(DEV_PATH, "/connect/error_warning_info_logs/")

most_recent_prod_error_path <- paste0(prod_error_file_path, "data_processing_error_info_log_connect_", format(Sys.Date(), "%Y%m%d"), ".log")
most_recent_dev_error_path <- paste0(dev_error_file_path, "data_processing_error_info_log_connect_", format(Sys.Date(), "%Y%m%d"), ".log")

# Error table constant setup----
error_days_to_read <- seq(from = Sys.Date() - 1, to = Sys.Date(), by = 'day')
error_cols_to_view <- c("timestamp", "log_msg", "script", "script_chunk", "r_environment")
error_days_to_read_string <- format(error_days_to_read, "%Y%m%d")
error_days_to_read_history <- 3
errors_days_to_read_history_string <- format(seq(from = Sys.Date() - error_days_to_read_history, to = Sys.Date(), by = 'day'), "%Y%m%d")

# Process graph specific constants-----
# Order to display processes
PROCESS_ORDER <- c("r_conf_ex_script")
PROCESS_PLOT_HEIGHT <- 500
process_order_table <- data.table(process_name = PROCESS_ORDER, order = 1:length(PROCESS_ORDER))
process_order_for_plot <- rev(paste(sapply(PROCESS_ORDER, function(pr) {
  return(c(paste0("PROD_", pr), paste0("DEV_", pr)))
}, USE.NAMES = F, simplify = T)))
