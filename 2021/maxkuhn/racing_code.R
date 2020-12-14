library(tidymodels)
library(finetune)
library(kernlab)

# ------------------------------------------------------------------------------

data(cells)
cells <- cells %>% select(-case)
set.seed(33)
cell_folds <- vfold_cv(cells)
roc_res <- metric_set(roc_auc)

# ------------------------------------------------------------------------------

svm_rec <- 
  recipe(class ~ ., data = cells) %>%
  step_YeoJohnson(all_predictors()) %>%
  step_normalize(all_predictors())

svm_spec <- 
  svm_rbf(cost = tune(), rbf_sigma = tune()) %>% 
  set_engine("kernlab") %>% 
  set_mode("classification")

svm_wflow <- 
  workflow() %>% 
  add_model(svm_spec) %>% 
  add_recipe(svm_rec)

svm_param <- 
  svm_wflow %>% 
  parameters() %>% 
  update(rbf_sigma = rbf_sigma(c(-7, -1)))

# ------------------------------------------------------------------------------

ctrl <- control_race(verbose_elim = TRUE)

set.seed(99)
svm_race <-
  svm_wflow %>% 
  tune_race_anova(resamples = cell_folds, grid = 20, metrics = roc_res,
                  control = ctrl)
svm_race

