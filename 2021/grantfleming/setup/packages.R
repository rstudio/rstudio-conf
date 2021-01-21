
# load packages
pacman::p_load(iml, rlang, readr, drake, stringr, dplyr, 
               tidyr, janitor, tidymodels)


# set the last level of our factors as the level of interest in prediction and metric calculation
options(yardstick.event_first = FALSE)

# NOTE: the yardstick.event_first option will be removed in the 0.1.0 release of the package.
# this also does not work with the most up to date version of the tune package (0.1.2)
# users will need to update the code in these scripts accordingly to account for this
# OR ensure that renv is properly loading older versions of yardstick (e.g 0.0.7)
