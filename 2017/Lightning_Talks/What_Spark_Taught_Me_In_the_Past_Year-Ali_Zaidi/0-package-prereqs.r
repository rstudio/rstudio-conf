
# Notes -------------------------------------------------------------------

## before being able to compile packages with gcc, you may need to update
## the $R_HOME/etc/Makeconf
## see https://github.com/Microsoft/microsoft-r-open/issues/11


# Update MRAN Mirror ------------------------------------------------------


r <- getOption("repos")
mran_date <- Sys.Date() - 1
r[["CRAN"]] <- paste0("https://mran.revolutionanalytics.com/snapshot/", mran_date)
options(repos = r)

# Install tidyverse and sparklyr ------------------------------------------


install.packages('devtools')
devtools::install_github("tidyverse/tidyverse")
install.packages(c('plotly'))

devtools::install_github("rstudio/sparklyr")
devtools::install_github('yihui/xaringan')



# text packages -----------------------------------------------------------

devtools::install_github("juliasilge/tidytext")
