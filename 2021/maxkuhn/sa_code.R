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

set.seed(234)
start_grid <- 
  svm_param %>% 
  update(
    cost = cost(c(-6, 1)),
    rbf_sigma = rbf_sigma(c(-6, -4))
  ) %>% 
  grid_regular(levels = 2)

set.seed(2)
svm_initial <- 
  svm_wflow %>% 
  tune_grid(resamples = cell_folds, grid = start_grid, metrics = roc_res)

ctrl_sa <- control_sim_anneal(no_improve = 10L, verbose = TRUE)

set.seed(1234)
svm_sa <-
  svm_wflow %>%
  tune_sim_anneal(
    resamples = cell_folds,
    metrics = roc_res,
    initial = svm_initial,
    param_info = svm_param,
    iter = 30,
    control = ctrl_sa
  )
svm_sa
