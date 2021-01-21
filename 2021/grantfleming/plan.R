
# restore packages from renv lock file
renv::restore()

# load here package
library(here)

# load pacman (install if not already available)
library(pacman)

# packages
source(here("setup/packages.R"))

# functions
source(here("setup/helpers.R"))

# make drake plan
plan = drake_plan(
  
  
  ######################################################## 
  ############# Data cleaning and processing #############
  ######################################################## 
  
  
  # read in raw COMPAS data
  df_raw = read_csv(here("data/compas-scores-two-years.csv")),
  
  # clean COMPAS data
  df = clean_compas(df_raw), 
  
  # append "_protected" to specified columns 
  df_protected = make_protected(df, c("age", "race", "sex")),
  
  # split the data into train/test sets 
  data_split = initial_split(df_protected, prop = 0.7),
  
  # preprocess the train/test data to prepare for modeling
  # save original data, train data, test data, and other objects into a list
  processed_data = gen_preprocessed_data(data_split, target = "two_year_recid"),
  
  
  ######################################################## 
  ##################### Modeling #########################
  ######################################################## 
  
  
  # create n bootstrap samples of the original data, where n = num
  boots = gen_boots(processed_data[["input_data"]], num = 2),
  
  # generate a list of tidymodels workflow objects corresponding to
  # the model specified in the names argument
  wflows = gen_mods(model_frame, 
                    names = c("logistic_regression", "nearest_neighbor", "svm_rbf", "random_forest"), 
                    mode = "classification", 
                    tune = FALSE,
                    recipe = processed_data[["recipe"]]),
  
  # create a list of dataframes, where each dataframe contains
  # all of the information we need to easily resample our models
  map_frame = map(wflows, gen_map_frame, 
                  boots = boots, 
                  metrics = metric_set(yardstick::accuracy, yardstick::roc_auc),
                  names = c("logistic_regression", "nearest_neighbor", "svm_rbf", "random_forest")), 
  
  # generate resamples and calculate metrics for each of the models 
  # specified in map_frame
  resamples = map2(map_frame, c("logistic_regression", "nearest_neighbor", "svm_rbf", "random_forest"), gen_resample, 
                   resample = boots,
                   metrics = metric_set(yardstick::accuracy, yardstick::roc_auc, yardstick::precision),
                   tune = FALSE, 
                   model_frame = model_frame,
                   df = processed_data[["train"]]), 
  
  # create featureless (floor) and optimal (ceiling) "models"
  # from the processed_data and calculate performance metrics over resamples
  bounding_models = gen_bounding(processed_data,
                                 target = "two_year_recid",
                                 boots = boots,
                                 metrics = metric_set(yardstick::accuracy),
                                 optimal_mean = 0.73,
                                 optimal_sd = 0.02),

  # plot performance of all models (including featureless/optimal) together
  baseline_plot = plot_baseline_models(bounding_models,
                                    resamples,
                                    num = 50,
                                    display_metric = "accuracy"),
  
  # recreate modeling formulas (gen_model_struct function used to 
  # easily allow for choosing optimal tuning parameters if tuning used)
  model_structs = map2(resamples, map_frame, gen_model_struct, 
                       tune = FALSE),
  
  # fit models on unprocessed input data and subset down to the two
  # best performing models, logistic and random forest
  fit_models = map(model_structs, fit, processed_data[["input_data"]]) %>% 
    set_names(c("logistic_regression", "nearest_neighbor", "svm_rbf", "random_forest")) %>% 
    magrittr::extract(c("logistic_regression", "random_forest")),
  
  # generate a list of dataframes, where each dataframe includes the
  # processed test data and predictions from the model(s)
  predictions = gen_pred_data(fit_models, 
                              mode = "classification", 
                              data_split = data_split),
  
  # generate a dataframe of model performance metrics  
  overall_metrics = map(predictions, 
                    gen_overall_metrics, 
                    target = "two_year_recid", 
                    estimate = "pred_class", 
                    val_interest = "1",
                    metrics = metric_set(yardstick::accuracy),  
                    mode = "classification") %>% 
    map2(c("logistic_regression", "random_forest"), assign_names) %>%  
    bind_rows(),
  
  
  ######################################################## 
  ################ Model Interpretability ################
  ######################################################## 
  
  
  # just need the processed test data here, so we can extract it from 
  # either of the prediction dataframes (or processed_data[["testing"]])
  iml_test_data = predictions[[1]] %>% 
    dplyr::select(-matches("pred_")),
  
  # make new predictions from the test data using a wrapper function
  # from the iml package 
  iml_preds = get_iml_preds(fit_models, 
                            data = iml_test_data, 
                            target = "two_year_recid"),
  
  # generate feature importance plots from the iml objects
  permutation_plots = plot_permutation_importance(iml_preds, 
                                                  model_names = c("logistic_regression", "random_forest"),
                                                  mode = "classification"),
  
  # generate partial dependence plots from iml objects
  global_plots = plot_global_interp(iml_preds, 
                                    model_names = c("logistic_regression", "random_forest"),
                                    display_feature = "priors_count"),
  
  
  ######################################################## 
  ##################### Auditing #########################
  ######################################################## 
  
  
  # calculate performance metrics across each of the specified protected groups
  # (only race here) AND each of the models and save to a dataframe 
  protected_metrics = map2(predictions, c("logistic_regression", "random_forest"), gen_protected_metrics,
                           target = "two_year_recid",
                           estimate = "pred_class", 
                           mode = "classification", 
                           protected = "race_protected",
                           privileged = "Caucasian", 
                           metrics = metric_set(yardstick::accuracy)) %>% 
    bind_rows(),
  
  # plot accuracy of each model across each of the protected groups 
  protected_metrics_plot_acc = plot_protected_metrics(protected_metrics, 
                                                      protected = "race_protected", 
                                                      display_metric = "accuracy"),
  
  # plot false positive rates for each model across each of the protected groups
  fp_error_direction_plot = plot_error_direction(predictions, 
                                                 mode = "classification",
                                                 display_feature = "race_protected", 
                                                 false_positive = TRUE, 
                                                 model = c("logistic_regression", "random_forest"), 
                                                 target = "two_year_recid"),
  
  # generate a pre-defined set of classification performance metrics for each of the 
  # protected groups RELATIVE to the privileged group (in this case, Caucasian)
  fairness_metrics = gen_fairness_metrics(predictions, 
                                          target = "two_year_recid", 
                                          model = c("logistic_regression", "random_forest"), 
                                          mode = "classification",
                                          protected = "race_protected",
                                          privileged = "Caucasian"),
  
  # plot the relative error rates of each of the models across protected groups
  error_plot = plot_fairness_metrics(fairness_metrics, 
                                     display_feature = "race_protected",
                                     metric = "error_rate"),
  
  # plot relative false positive rates for each model across each of the protected groups
  fpr_plot = plot_fairness_metrics(fairness_metrics, 
                                   display_feature = "race_protected",
                                   metric = "fpr"),
  
  
  ######################################################## 
  ################## Bias Mitigation #####################
  ######################################################## 
  
  
  # NOTE: from this point forward we will only use the predictions from the
  # random forest model, as this model tended to perform better than the others
  pred_data_orig = predictions[[2]], 
  
  # generate "optimal" classification thresholds (as measured by maximizing Youden's J)
  threshold_frame = gen_optimal_thresholds(pred_data_orig,
                                           protected = "race_protected", 
                                           target = "two_year_recid",
                                           prob_event = "pred_1"),
  
  # generate new predictions based upon the new classification thresholds
  mitigated_predictions = gen_mitigated_preds(pred_data_orig, 
                                              threshold_frame, 
                                              protected = "race_protected",
                                              prob_event = "pred_1"),
  
  # generate metrics of model performance across each of the protected groups
  opt_protected_metrics = gen_protected_metrics(mitigated_predictions, 
                                                model = "random_forest", 
                                                target = "two_year_recid",
                                                estimate = "pred_class", 
                                                mode = "classification", 
                                                protected = "race_protected",
                                                privileged = "Caucasian",  
                                                metrics = metric_set(yardstick::accuracy)) %>% 
    bind_rows(),
  
  # plot accuracy of each model across each of the protected groups 
  opt_protected_metrics_plot_acc = plot_protected_metrics(opt_protected_metrics, 
                                                      protected = "race", 
                                                      display_metric = "accuracy"),
  
  # plot false positive rate of each model across each of the protected groups 
  opt_fp_error_direction_plot = plot_error_direction(mitigated_predictions, 
                                                 mode = "classification",
                                                 display_feature = "race_protected", 
                                                 false_positive = TRUE, 
                                                 model = "random_forest", 
                                                 target = "two_year_recid"),
  
  # generate a pre-defined set of classification performance metrics for each of the 
  # protected groups RELATIVE to the privileged group (in this case, Caucasian)
  opt_fairness_metrics = gen_fairness_metrics(mitigated_predictions, 
                                              target = "two_year_recid", 
                                              model = "random_forest", 
                                              mode = "classification",
                                              protected = "race", 
                                              privileged = "Caucasian"),
  
  # plot the relative error rates of each of the models across protected groups
  opt_error_plot = plot_fairness_metrics(opt_fairness_metrics, 
                                     display_feature = "race_protected",
                                     metric = "error_rate"),
  
  # plot relative false positive rates for each model across each of the protected groups
  opt_fpr_plot = plot_fairness_metrics(opt_fairness_metrics, 
                                   display_feature = "race_protected",
                                   metric = "fpr"),
  
  # plot relative false positive rates across groups for the models without
  # "optimal" classification thresholds and those with them
  fairness_fpr_comparison = plot_fairness_comparison(fairness_metrics, 
                                                     opt_fairness_metrics,
                                                     model = "random_forest",
                                                     display_feature = "race_protected", 
                                                     metric = "fpr"),
  
  # plot error rates across groups for the models without
  # "optimal" classification thresholds and those with them
  error_fpr_comparison = plot_error_comparison(pred_data_orig,
                        mitigated_predictions,
                        mode = "classification",
                        display_feature = "race",
                        false_positive = TRUE,
                        model = "random_forest",
                        target = "two_year_recid")
  
)

# execute the plan
make(plan)


