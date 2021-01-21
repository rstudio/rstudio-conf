

# generate a dataframe of parsnip model functions for use in later modeling functions
gen_model_frame = function() {
  
  tune_mods = list(linear_reg(),
                   logistic_reg(
                     mixture = tune(),
                     penalty = tune()
                   ),
                   svm_rbf(
                     cost = tune(),
                     margin = tune()
                   ),
                   nearest_neighbor(
                     neighbors = tune()
                   ),
                   decision_tree(
                     tree_depth = tune(),
                     min_n = tune()
                   ),
                   rand_forest(
                     trees = 1000,
                     mtry = tune(),
                     min_n = tune()
                   ),
                   boost_tree(
                     mtry = tune(),
                     min_n = tune(),
                     tree_depth = tune(),
                     learn_rate = tune(),
                     loss_reduction = tune()
                   ),
                   mars())
  
  params = list(list(),
                list(penalty(), mixture()),
                list(),
                list(),
                list(tree_depth(), min_n()),
                list(mtry(), min_n()),
                list(mtry(), min_n(), tree_depth(), learn_rate(), loss_reduction()),
                list())
  
  tibble(model_name = list("linear_regression", "logistic_regression", "svm_rbf", "nearest_neighbor",
                           "decision_tree", "random_forest", "boosted_trees", "mars"),
         model_function = list(linear_reg(), logistic_reg(), svm_rbf(), nearest_neighbor(),
                               decision_tree(), rand_forest(trees = 1000), boost_tree(), mars()),
         model_engine = list("lm", "glm", "kernlab", "kknn", "rpart", "randomForest", "xgboost", "earth"),
         tune_mods = tune_mods) %>%
    unnest(c(model_name, model_engine)) 
  
}
model_frame = gen_model_frame()

# tidy-friendly dropping of cols that contain too many of certain vals (or NAs eventually)
col_dropper = function(df, val_interest = NA, threshold = 0.10, missing = FALSE) {
  
  drop_cols = purrr::map(df, function(x) sum(x == val_interest)/length(x)) %>% 
    enframe() %>% 
    unnest(value) %>% 
    filter(value >= threshold) %>% 
    pull(name)
  
  df %>% 
    dplyr::select(!any_of(drop_cols))
  
}

# helper function to add "_protected" suffix to columns in a dataframe
protected = function(x) {
  paste0(x, "_protected")
}

# use protected to rename columns in a dataframe with "_protected" suffix
make_protected = function(df, string) {
  if (is.data.frame(df) == TRUE) {
    df %>% 
      rename_with(protected, matches(string))
  } else {
    stop("This function only takes dataframes (or tibbles) as inputs")
  }
}

# hardcoded function to assign element names in a list to a column in a dataframe
assign_names = function(df, names) {
  
  df %>% 
    mutate(model = {{names}}) %>% 
    relocate(model, everything())
  
}

# function to clean compas data
clean_compas = function(df) {
  
  df %>% 
    filter(days_b_screening_arrest <= 30) %>%
    filter(days_b_screening_arrest >= -30) %>%
    filter(is_recid != -1) %>%
    filter(c_charge_degree != "O") %>%
    filter(compas_screening_date <= as.Date("2014-04-01")) %>% 
    dplyr::select(age_cat, c_charge_degree, race, sex, priors_count, 
                  juv_fel_count, juv_misd_count, juv_other_count, two_year_recid) %>% 
    mutate(race = ifelse(race %in% c("Native American", "Asian", "Other"), "Other", race)) %>% 
    # mutate(race = factor(race, levels = c("Caucasian", "African-American", "Hispanic"))) %>%
    mutate(juv_charge = ifelse(juv_fel_count > 0 | juv_misd_count > 0 | 
                                 juv_other_count > 0, "yes", "no")) %>% 
    dplyr::select(-c(juv_fel_count, juv_misd_count, juv_other_count)) %>%
    mutate(two_year_recid = factor(two_year_recid, levels = c("0", "1"))) %>%
    clean_names() 
  
}

# internal function for gen_bounding_models
bake_resamples = function(processed_data, boots) {
  
  resample_frame = tibble(recipe = list(processed_data[["recipe_prepped"]]),
                          resample = list(boots)) %>% 
    unnest(resample)
  
  resample_list = purrr::map2(resample_frame$recipe, resample_frame$splits, bake)
  
  resample_list
  
}


# preprocess data and prepare it for modeling
gen_preprocessed_data = function(data_split, target = NA, model_names = NA, split_ratio = NA,
                                 corr_threshold = 1, impute = FALSE, standardize = FALSE,
                                 seed = NA) {
  
  if (!is.na(seed)) {
    set.seed(seed)
  }
  
  if ("boosted_trees" %in% model_names) {
    
    if (!is.na(split_ratio)) {
      
      data_split = data_split$data %>% 
        mutate(across(all_of(target), as.numeric)) %>% 
        initial_split(split_ratio)
      
    } else {
      
      abort("must provide a numeric value between 0 and 1 for split_ratio if using boosted_trees")
      
    }
    
  }
  
  
  # get column types
  col_types = data_split %>%
    training() %>% 
    dplyr::summarize(across(everything(), class)) %>% 
    pivot_longer(cols = everything(),
                 names_to = "variables",
                 values_to = "type") 
  
  if (any(col_types$type == "integer")) {
    
    col_types = data_split %>%
      training() %>% 
      mutate(across(where(is.integer), as.numeric)) %>% 
      dplyr::summarize(across(everything(), class)) %>% 
      pivot_longer(cols = everything(),
                   names_to = "variables",
                   values_to = "type") 
    
  }
  
  
  if ("boosted_trees" %in% model_names) {
    
    stop("boosted_trees or other xgboost-like models are not yet supported")
    
  } 
  
  df_protected = data_split %>% 
    training()
  
  # get a formula for creating our recipe
  form = paste(paste(target, "~"), str_c(colnames(df_protected %>% dplyr::select(-all_of(target))), 
                                         collapse = "+"))
  
  if (standardize == TRUE) {
    
    if (impute == TRUE) {
      
      if (any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) %>% 
          step_medianimpute(all_numeric(), -all_outcomes()) %>% 
          step_modeimpute(all_nominal(), -all_outcomes()) %>% 
          step_range(all_numeric(), -all_outcomes()) 
        
      } else if (!any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_modeimpute(all_nominal(), -all_outcomes()) 
        
      } else if (any(col_types$type == "numeric") & !any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) %>% 
          step_medianimpute(all_numeric(), -all_outcomes()) %>% 
          step_range(all_numeric(), -all_outcomes())
      }
      
    } else {
      
      if (!any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes())
        
      } else {
        
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) %>% 
          step_range(all_numeric(), -all_outcomes())
        
      }
      
    }
    
  } else {
    
    if (impute == TRUE) {
      
      if (any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) %>% 
          step_medianimpute(all_numeric(), -all_outcomes()) %>% 
          step_modeimpute(all_nominal(), -all_outcomes())
        
      } else if (!any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_modeimpute(all_nominal(), -all_outcomes()) 
        
      } else if (any(col_types$type == "numeric") & !any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) %>% 
          step_medianimpute(all_numeric(), -all_outcomes()) 
      }
      
    } else {
      
      if (!any(col_types$type == "numeric") & any(col_types$type == "factor")) {
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes())
        
      } else {
        
        rec = recipe(df_protected, form) %>%
          step_nzv(all_predictors(), -all_outcomes()) %>%
          step_corr(all_numeric(), threshold = corr_threshold, -all_outcomes()) 
        
      }
      
    }
    
  }
  
  
  # nzv, corr, normalize, medianimpute, modeimpute, center, scale, dummy, discretize, dummy,
  # unknown
  
  # formalize our pre-processing steps
  rec_prep = rec %>% 
    prep()
  
  # preprocess our train data by "baking" it with our prepped recipe
  train_data = bake(rec_prep, training(data_split) %>% mutate(across(where(is.integer), as.numeric)))
  
  # preprocess our test data by "baking" it with our prepped recipe
  test_data = bake(rec_prep, testing(data_split) %>% mutate(across(where(is.integer), as.numeric)))
  
  # get original data for output
  input_data = df_protected %>% 
    mutate(across(where(is.integer), as.numeric))
  
  # get features
  data_feats = train_data %>% 
    colnames() 
  
  # get a formula for creating our recipe
  final_form = paste(paste(target, "~"), str_c(colnames(train_data %>% dplyr::select(-all_of(target))), 
                                               collapse = "+"))
  
  # return a list containing our two pre-processed datasets
  list("input_data" = input_data,
       "train_raw" = training(data_split),
       "test_raw" = testing(data_split),
       "train" = train_data, 
       "test" = test_data,
       "features" = data_feats,
       "recipe" = rec,
       "recipe_prepped" = rec_prep,
       "formula" = final_form)
  
}


# internal function for gen_mods
modder = function(model_function, model_engine, model_mode) {
  
  model_function %>%
    set_engine(model_engine) %>%
    set_mode(model_mode)
  
}

# generate parsnip models from model_frame
gen_mods = function(model_frame, names, mode = NA, tune = FALSE, recipe) {
  
  if (!all(names %in% model_frame$model_name)) {
    
    abort("one or more invalid names entered; check gen_model_frame() for valid model_name")
    
  }
  
  if (is.na(mode)) {
    stop("Need to declare whether model is of type 'regression' or 'classification'")
  }  
  
  if (tune == TRUE) {
    
    interim = model_frame %>% 
      slice(order(factor(model_name, levels = names))) %>% 
      filter(model_name %in% names) %>% 
      mutate(mode = mode) %>%
      dplyr::select(-model_name) %>% 
      mutate(data = list(data)) %>% 
      select(tune_mods, model_engine, mode) %>% 
      rename(model_function = 1)
    
    mods = purrr::pmap(interim, modder)
    
    wflows = map(mods, gen_workflow, recipe)
    
    return(wflows)
    
  } else {
    
    interim = model_frame %>%
      slice(order(factor(model_name, levels = names))) %>% 
      filter(model_name %in% names) %>% 
      mutate(mode = mode) %>%
      dplyr::select(-model_name, -tune_mods)
    
    mods = purrr::pmap(interim, modder)
    
    wflows = map(mods, gen_workflow, recipe)
    
  }
  
  return(wflows)
  
}


gen_workflow = function(model, recipe) {
  workflows::workflow() %>%
    add_model(model) %>%
    add_recipe(recipe)
}


gen_boots = function(df, num_resamples) {
  boots = df %>%
    bootstraps(times = num_resamples)
}


gen_resample = function(wflow, name, resample, metrics, tune = FALSE, model_frame, df, target,
                        size = 30, grid_points = 30) {
  
  # pull out workflow from map frame
  
  if (any(class(wflow) == "data.frame") | any(class(wflow) == "list")) {
    
    wflow = wflow$wflow[[1]]
    
  }
  
  if (tune == FALSE) {
    
    if (is.na(metrics)) {
      
      abort("need to provide one or more metrics generated by yardstick::metric_set()")
      
    } else if (!any(class(metrics) == "metric_set")) {
      
      # option triggered if only one metric entered into metrics argument
      
      fit_resamples(
        wflow,
        resamples = resample,
        control = control_resamples(extract = function(x) extract_model(x)),
        metrics = metric_set(metrics)) %>%
        mutate(model = name) %>%
        dplyr::select(model, everything())
      
    } else {
      
      # option triggered if multiple metrics generated via metric_set are entered into metrics argument 
      
      fit_resamples(
        wflow,
        resamples = resample,
        control = control_resamples(extract = function(x) extract_model(x)),
        metrics = metrics) %>%
        mutate(model = name) %>%
        dplyr::select(model, everything())
      
    }
    
    
  } else {
    
    if (is.na(metrics)) {
      
      abort("need to provide one or more metrics generated by yardstick::metric_set()")
      
    } 
    
    if (name == "logistic_regression") {
      
      # grid = wflow %>% 
      #   parameters() %>% 
      #   grid_latin_hypercube(size = 30)
      
      
      if (!any(class(metrics) == "metric_set")) {
        
        # option triggered if only one metric entered into metrics argument
        
        fit_resamples(
          wflow,
          resamples = resample,
          control = control_resamples(extract = function(x) extract_model(x)),
          metrics = metric_set(metrics)) %>%
          mutate(model = name) %>%
          dplyr::select(model, everything())
        
      } else {
        
        fit_resamples(
          wflow,
          resamples = resample,
          control = control_resamples(extract = function(x) extract_model(x)),
          metrics = metrics) %>%
          mutate(model = name) %>%
          dplyr::select(model, everything())
        
      }
      
    } else {
      
      df_small = df %>% 
        dplyr::select(!matches(c("protected", target)))
      
      grid = wflow %>% 
        parameters() %>% 
        finalize(x = df_small) %>% 
        pull(object) %>% 
        grid_latin_hypercube(size = 30)
      
    }
    
    if (!any(class(metrics) == "metric_set")) {
      
      # option triggered if only one metric entered into metrics argument
      
      tune_grid(
        wflow,
        grid = grid,
        resamples = resample,
        metrics = metric_set(metrics)) #%>%
      # mutate(model = name) %>%
      # dplyr::select(model, everything())
      
    } else {
      
      tune_grid(
        wflow,
        grid = grid,
        resamples = resample,
        metrics = metrics) #%>%
      mutate(model = name) %>%
        dplyr::select(model, everything())
      
    }
    
    # tune_bayes(
    #   model,
    #   preprocessor = recipe,
    #   resamples = resample,
    #   iter = 10,
    #   control = control_bayes(no_improve = 20, verbose = TRUE),
    #   metrics = metric_set(metric)) %>%
    #   mutate(model = name) %>%
    #   dplyr::select(model, everything())
    
  }
  
}


gen_model_struct = function(resample, model_workflow, tune = FALSE, interest_metric = NA) {
  
  if (tune == FALSE) {
    
    if (any(class(model_workflow) == "data.frame") | any(class(model_workflow) == "list")) {
      
      model_workflow = model_workflow$wflow[[1]] 
      
    }
    
    model_workflow
    
  } else {
    
    # pull out workflow from map frame
    
    if (any(class(model_workflow) == "data.frame") | any(class(model_workflow) == "list")) {
      
      model_workflow = model_workflow$wflow[[1]] 
      
    }
    
    if (is.na(tune)) {
      
      abort("enter a string corresponding to one of the metrics used for tuning (e.g 'precision')")
      
    }
    
    best_mod = resample %>% 
      select_best(tune, metric = interest_metric)
    
    finalize_workflow(model_workflow, best_mod)
    
  }
  
}


gen_map_frame = function(wflow, boots, metrics = NA, names) {
  
  
  map_frame = tibble(wflow = list(wflow),
                     resample = list(boots),
                     metrics = list(metrics),
                     name = list(names))
  
}


gen_means = function(resamples, bounding_models) {
  
  resample_means = purrr::map(resamples, resample_cleaner) %>%
    bind_rows()
  
  bounding_means = purrr::map(bounding_models, bounding_cleaner) %>%
    bind_rows()
  
  bind_rows(resample_means, bounding_means) %>%
    mutate(estimate = round(estimate, 3)) %>%
    arrange(estimate)
  
}


resample_cleaner = function(resample) {
  
  resample %>%
    collect_metrics() %>%
    janitor::clean_names() %>%
    dplyr::select(-std_err, -n, -estimator) %>%
    rename(estimate = mean)
  
}


bounding_cleaner = function(bounding) {
  
  bounding %>%
    mutate(estimate = mean(estimate)) %>%
    slice(1)
  
}


gen_bounding = function(processed_data, target, boots, metrics, 
                        optimal_mean = NA, optimal_sd = NA) {
  
  bounding_models = list()
  
  holder = bake_resamples(processed_data, boots)
  
  bounding_models[["f_less"]] = purrr::map_df(holder, gen_featureless, target, metrics)
  
  if (!is.na(optimal_mean) | !is.na(optimal_sd)) {
    
    if (is.numeric(optimal_mean) & is.numeric(optimal_sd)) {
      
      bounding_models[["optimal"]] = gen_optimal(optimal_mean, optimal_sd, num = nrow(bounding_models[["f_less"]])) %>% 
        mutate(metric = bounding_models$f_less$metric)
      
    } else {
      
      stop("ensure that optimal_mean and optimal_sd are each numeric values")
      
    }
    
  }
  
  return(bounding_models)
  
}


resample_extractor = function(resample) {
  
  resample %>%
    dplyr::select(-.notes, -id, -splits) %>%
    unnest(.metrics) %>%
    clean_names() %>%
    pull(estimate)
  
}


resample_name_extractor = function(resample) {
  
  temp_name = resample %>%
    distinct(model) %>%
    pull()
  
}


two_test_interp = function(v1, v2) {
  
  t.test(v1, v2) %>%
    tidy() %>%
    dplyr::select(p.value) %>%
    rename(pvalue_interp = p.value) %>%
    mutate(pvalue_interp = ifelse(pvalue_interp == 1, NA, pvalue_interp)) %>%  # need to case_when this
    mutate(pvalue_interp = round(pvalue_interp, 3))
  
}


two_test_bbox = function(v1, v2) {
  
  t.test(v1, v2) %>%
    tidy() %>%
    dplyr::select(p.value) %>%
    rename(pvalue_bbox = p.value) %>%
    mutate(pvalue_bbox = ifelse(pvalue_bbox == 1, NA, pvalue_bbox)) %>%  # need to case_when this
    mutate(pvalue_bbox = round(pvalue_bbox, 3))
  
}


gen_t_tests = function(means, bounding_models, resamples) {
  
  bounding_set = purrr::map(bounding_models, pull, estimate)
  
  resample_names = purrr::map(resamples, resample_name_extractor)
  names(resamples) = resample_names
  resample_set = purrr::map(resamples, resample_extractor)
  full_set = append(bounding_set, resample_set)
  
  interp_frame = purrr::map(full_set, two_test_interp, resample_set[[1]]) %>%
    bind_rows() %>%
    mutate(model = names(full_set))
  
  bbox_frame = purrr::map(full_set, two_test_bbox, resample_set[[2]]) %>%
    bind_rows() %>%
    mutate(model = names(full_set))
  
  df = means %>%
    left_join(interp_frame, by = "model") %>%
    left_join(bbox_frame, by = "model")
  
  return(df)
  
}


metric_selector = function(resamples) {
  
  resamples %>%
    unnest(.metrics) %>%
    dplyr::select(model, .metric, .estimate) %>%
    janitor::clean_names()
  
}


plot_baseline_models = function(bounding_models, resamples, num_resamples = NA,
                                full_plot = FALSE, display_metric = NA) {
  
  if (is.na(display_metric)) {
    
    scores = purrr::map(resamples, metric_selector) %>%
      bind_rows() %>%
      arrange(model)
    
    if (length(unique(scores$metric)) > 1) {
      
      abort("Multiple resampling metrics detected. Please indicate the desired metric to plot by 
            entering it as a string in the 'display_metric' argument of the function")
      
    } 
    
  } else {
    
    scores = purrr::map(resamples, metric_selector) %>%
      bind_rows() %>%
      arrange(model) %>%
      filter(metric == display_metric)
    
  }
  
  if (is.na(num_resamples)) {
    
    abort("provide number of resamples metrics calculated for the models")
    
  }
  
  if (full_plot == FALSE) {
    
    if (display_metric %in% c("rmse", "mae", "mse", "rse", "mape", "smape")) {
      
      scores %>%
        ggplot(aes(x = reorder(model, -estimate), y = estimate, color = model)) +
        geom_boxplot() +
        # theme_grey(base_size = 16) +
        coord_flip() +
        labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
             title = "Two-Measure Performance Baseline")
      
    } else {
      
      scores %>%
        ggplot(aes(x = reorder(model, estimate), y = estimate, color = model)) +
        geom_boxplot() +
        theme_grey(base_size = 16) +
        coord_flip() +
        labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
             title = "Two-Measure Performance Baseline")
      
    }
    
  } else {
    
    if (display_metric %in% c("rmse", "mae", "mse", "rse", "mape", "smape")) {
      
      if (is.null(bounding_models[["optimal"]])) {
        
        scores_plotting = bind_rows(bounding_models[["f_less"]], scores) %>%
          arrange(model) %>%
          filter(metric == display_metric)
        
        scores_plotting %>%
          ggplot(aes(x = reorder(model, -estimate), y = estimate, color = model)) +
          geom_boxplot() +
          # geom_text(aes(label = estimate), vjust = -0.3) +
          # theme_grey(base_size = 16) +
          coord_flip() +
          labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
               title = "Three-Measure Performance Baseline")
        
      } else {
        
        scores_plotting = bind_rows(bounding_models[["f_less"]], scores, bounding_models[["optimal"]]) %>%
          arrange(model) %>%
          filter(metric == display_metric)
        
        scores_plotting %>%
          ggplot(aes(x = reorder(model, -estimate), y = estimate, color = model)) +
          geom_boxplot() +
          # geom_text(aes(label = estimate), vjust = -0.3) +
          # theme_grey(base_size = 16) +
          coord_flip() +
          labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
               title = "Four-Measure Performance Baseline")
        
      } 
      
    } else {
      
      if (is.null(bounding_models[["optimal"]])) {
        
        scores_plotting = bind_rows(bounding_models[["f_less"]], scores) %>%
          arrange(model) %>%
          filter(metric == display_metric)
        
        scores_plotting %>%
          ggplot(aes(x = reorder(model, estimate), y = estimate, color = model)) +
          geom_boxplot() +
          # geom_text(aes(label = estimate), vjust = -0.3) +
          # theme_grey(base_size = 16) +
          coord_flip() +
          labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
               title = "Three-Measure Performance Baseline")
        
      } else {
        
        scores_plotting = bind_rows(bounding_models[["f_less"]], scores, bounding_models[["optimal"]]) %>%
          arrange(model) %>%
          filter(metric == display_metric)
        
        scores_plotting %>%
          ggplot(aes(x = reorder(model, estimate), y = estimate, color = model)) +
          geom_boxplot() +
          # geom_text(aes(label = estimate), vjust = -0.3) +
          # theme_grey(base_size = 16) +
          coord_flip() +
          labs(x = "Model", y = paste(display_metric, "over", as.character(num_resamples), "resamples"),
               title = "Four-Measure Performance Baseline")
        
      } 
      
    }
    
  }
  
}

# function to estimate our featureless performance
gen_featureless = function(holder, target, metrics) {
  
  target_type = holder %>% 
    dplyr::select(target) %>% 
    pull() %>% 
    class()
  
  if (target_type == "factor") {
    
    target_vec = holder %>% 
      dplyr::select(target) %>% 
      pull(target)
    
    common_val = target_vec %>% 
      enframe() %>% 
      group_by(value) %>% 
      dplyr::count() %>% 
      arrange(-n) %>%
      ungroup() %>% 
      dplyr::slice(1) %>% 
      pull(value) %>% 
      as.character()
    
    f_less_vec = holder %>% 
      dplyr::select(target) %>% 
      mutate(f_less = factor(common_val, levels = levels(target_vec))) %>% 
      pull(f_less)
    
    holder %>% 
      dplyr::select(target) %>% 
      mutate(f_less = factor(common_val, levels = levels(target_vec))) %>% 
      metrics(truth = target_vec, estimate = f_less_vec) %>% 
      dplyr::rename(metric = .metric, estimate = .estimate) %>%
      mutate(model = "f_less") %>% 
      dplyr::select(model, metric, estimate)
    
  } else {
    
    target_vec = holder %>% 
      dplyr::select(target) %>% 
      pull(target)
    
    common_value = target_vec %>% 
      enframe() %>% 
      summarize(avg = mean(value)) %>% 
      pull()
    
    f_less_vec = holder %>% 
      dplyr::select(target) %>% 
      mutate(f_less = common_value) %>% 
      pull(f_less)
    
    holder %>% 
      dplyr::select(target) %>% 
      mutate(f_less = common_value) %>% 
      metrics(truth = target_vec, estimate = f_less_vec) %>% 
      dplyr::rename(metric = .metric, estimate = .estimate) %>%
      mutate(model = "f_less") %>% 
      dplyr::select(model, metric, estimate) %>% 
      mutate(estimate = ifelse(estimate == Inf, NA, estimate))
    
  }
  
}

# function to generate optimal bayes error
gen_optimal = function(optimal_mean, optimal_sd, num) {
  
  distribution = rnorm(n = num, mean = optimal_mean, sd = optimal_sd)
  
  tibble("model" = "optimal",
         "metric" = "accuracy",
         "estimate" = distribution)
  
}


gen_workflow = function(model, recipe) {
  
  workflows::workflow() %>%
    add_model(model) %>% 
    add_recipe(recipe) 

}


gen_pred_data = function(fit_mods, mode, data_split) {
  
  if (mode == "classification") {
    
    if (class(fit_mods) == "list") {
      
      new_recs = purrr::map(fit_mods, pull_workflow_prepped_recipe)
      
      new_fits = purrr::map(fit_mods, pull_workflow_fit)
      
      new_test_data = purrr::map(new_recs, bake, testing(data_split))
      
      new_preds = map2(new_fits, new_test_data, predict, type = "prob")
      
      bound_data = map2(new_test_data, new_preds, mode = mode, add_preds)
      
    } else if (class(fit_mods) == "workflow") {
      
      new_recs = pull_workflow_prepped_recipe(fit_mods)
      
      new_fits = pull_workflow_fit(fit_mods)
      
      new_test_data = bake(new_recs, testing(data_split))
      
      new_preds = new_fits %>% 
        predict(new_test_data, type = "prob")
      
      bound_data = add_preds(new_test_data, new_preds, mode = mode)
      
    }
    
  } else if (mode == "regression") {
    
    new_recs = map(fit_mods, pull_workflow_prepped_recipe)
    
    new_fits = map(fit_mods, pull_workflow_fit)
    
    new_test_data = map(new_recs, bake, testing(data_split))
    
    new_preds = map2(new_fits, new_test_data, predict, type = "numeric")
    
    bound_data = map2(new_test_data, new_preds, mode =  mode, add_preds)
    
  } else {
    
    stop("mode must be either 'classification' or 'regression'")
    
  }
  
  return(bound_data)
  
}


gen_overall_metrics = function(df, target, estimate, val_interest,  
                               metrics, mode) {
  
  df_target = df %>%
    pull(target)
  
  df_estimate = df %>%
    pull(estimate)
  
  if (mode == "classification") {
    
    if (is.na(target) | is.na(estimate)) {
      
      abort("need to provide values for target and estimate if analyzing a classification model_model")
      
    } else {
      
      prob_id = str_c("pred", val_interest, sep = "_")
      
      tibble(data = list(df),
             truth = list(df_target),
             estimate = list(df_estimate),
             prob = list(prob_id)) %>%
        purrr::pmap(metrics) %>%
        magrittr::extract2(1) %>%
        clean_names()
      
    }
    
  } else if (mode == "regression") {
    
    tibble(data = list(df),
           truth = list(df_target),
           estimate = list(df_estimate)) %>%
      purrr::pmap(metrics) %>%
      magrittr::extract2(1) %>%
      clean_names()
    
  } else {
    
    abort("mode argument only accepts values 'regression' or 'classification'")
    
  }
  
}


gen_protected_metrics = function(df, model, target, estimate, mode,
                                 protected, privileged, metrics) {
  
  if (is.na(protected)) {
    
    vars = df %>% 
      dplyr::select(matches("_protected")) %>%
      colnames() 
    
    protected = vars
    
  } else {
    
    vars = df %>% 
      dplyr::select(matches(protected)) %>%
      colnames()
    
  }
  
  if (is.null(metrics)) {
    
    abort("metrics argument requires metric functions from the yardstick package as inputs")
    
    # TODO: different metrics check needed
    
  } 
  
  if (mode == "classification") {
    
    group_metrics_raw = vars %>% 
      set_names(vars) %>% 
      purrr::map_df( ~ {
        
        df %>%
          group_by(across(all_of(.x))) %>%
          metrics(two_year_recid, pred_1, estimate = pred_class)
        
      },
      .id = "protected_feature") %>% 
      clean_names() %>% 
      dplyr::select(-estimator) %>% 
      unite("group", matches("_protected"), na.rm = TRUE) %>% 
      arrange(protected_feature, group) %>% 
      mutate(id = NA)
    
    # TODO: need to clarify need for id and different sub_group creation across modes 
    
    holder = list()
    for (i in 1:length(protected)) {
      holder[[i]] = group_metrics_raw %>% 
        mutate(id = ifelse(str_detect(protected_feature, protected[[i]]), 
                           protected[[i]], id)) %>% 
        mutate(privileged = ifelse(str_detect(group, privileged[[i]]), TRUE, FALSE)) 
    }
    
    # TODO: error checking for holder privileged col creation bc it "works" even if no matches
    
    group_metrics = holder %>% 
      bind_rows() %>% 
      drop_na() %>% 
      mutate(model = model) %>% 
      relocate(model, id, protected_feature, group, privileged, metric, estimate) 
    
  } else if (mode == "regression") {
    
    group_metrics_raw = vars %>% 
      set_names(vars) %>% 
      purrr::map_dfr( ~ {
        
        df %>% 
          group_by(across(all_of(.x))) %>% 
          metrics({{target}}, {{estimate}})
        
      },
      .id = "protected_feature") %>% 
      clean_names() %>% 
      dplyr::select(-estimator) %>% 
      unite("group", matches("_protected"), na.rm = TRUE) %>% 
      arrange(protected_feature, group) %>% 
      mutate(id = NA)
    
    
    holder = list()
    for (i in 1:length(protected)) {
      holder[[i]] = group_metrics_raw %>% 
        mutate(id = ifelse(str_detect(protected_feature, protected[[i]]), 
                           protected[[i]], id)) %>% 
        mutate(privileged = ifelse(str_detect(group, privileged[[i]]), TRUE, FALSE))
    }
    
    group_metrics = holder %>% 
      bind_rows() %>% 
      drop_na() %>% 
      mutate(model = model) %>% 
      relocate(model, id, protected_feature, group, privileged, metric, estimate) 
    
  } else {
    
    abort("mode argument only accepts values 'regression' or 'classification'")
    
  }
  
}


gen_protected_metrics_sf = function(df, model, target, estimate, mode,
                                    protected, privileged, metrics) {
  
  if (is.na(protected)) {
    
    vars = df %>% 
      dplyr::select(matches("_protected")) %>%
      colnames() 
    
    protected = vars
    
  } else {
    
    vars = df %>% 
      dplyr::select(matches(protected)) %>%
      colnames()
    
  }
  
  if (is.null(metrics)) {
    
    abort("metrics argument requires metric functions from the yardstick package as inputs")
    
    # TODO: different metrics check needed
    
  } 
  
  if (mode == "classification") {
    
    group_metrics_raw = vars %>% 
      set_names(vars) %>% 
      purrr::map_df( ~ {
        
        df %>%
          group_by(across(all_of(.x))) %>%
          metrics(score_factor, pred_1, estimate = pred_class)
        
      },
      .id = "protected_feature") %>% 
      clean_names() %>% 
      dplyr::select(-estimator) %>% 
      unite("group", matches("_protected"), na.rm = TRUE) %>% 
      arrange(protected_feature, group) %>% 
      mutate(id = NA)
    
    # TODO: need to clarify need for id and different sub_group creation across modes 
    
    holder = list()
    for (i in 1:length(protected)) {
      holder[[i]] = group_metrics_raw %>% 
        mutate(id = ifelse(str_detect(protected_feature, protected[[i]]), 
                           protected[[i]], id)) %>% 
        mutate(privileged = ifelse(str_detect(group, privileged[[i]]), TRUE, FALSE)) 
    }
    
    # TODO: error checking for holder privileged col creation bc it "works" even if no matches
    
    group_metrics = holder %>% 
      bind_rows() %>% 
      drop_na() %>% 
      mutate(model = model) %>% 
      relocate(model, id, protected_feature, group, privileged, metric, estimate) 
    
  } else if (mode == "regression") {
    
    group_metrics_raw = vars %>% 
      set_names(vars) %>% 
      purrr::map_dfr( ~ {
        
        df %>% 
          group_by(across(all_of(.x))) %>% 
          metrics({{target}}, {{estimate}})
        
      },
      .id = "protected_feature") %>% 
      clean_names() %>% 
      dplyr::select(-estimator) %>% 
      unite("group", matches("_protected"), na.rm = TRUE) %>% 
      arrange(protected_feature, group) %>% 
      mutate(id = NA)
    
    
    holder = list()
    for (i in 1:length(protected)) {
      holder[[i]] = group_metrics_raw %>% 
        mutate(id = ifelse(str_detect(protected_feature, protected[[i]]), 
                           protected[[i]], id)) %>% 
        mutate(privileged = ifelse(str_detect(group, privileged[[i]]), TRUE, FALSE))
    }
    
    group_metrics = holder %>% 
      bind_rows() %>% 
      drop_na() %>% 
      mutate(model = model) %>% 
      relocate(model, id, protected_feature, group, privileged, metric, estimate) 
    
  } else {
    
    abort("mode argument only accepts values 'regression' or 'classification'")
    
  }
  
}


plot_protected_metrics_dummy = function(group_metrics, group = NA, privileged = NA, metric = NA) {
  
  metrics_filtered = group_metrics %>% 
    filter(str_detect(group, {{group}})) %>% 
    clean_names() %>% 
    filter(metric == {{metric}}) %>% 
    dplyr::select(model, group, metric, estimate)
  
  models = metrics_filtered %>% 
    distinct(model) %>% 
    pull()
  
  if (length(models) > 1) {
    
    metrics_filtered %>% 
      ggplot(aes(x = group, y = estimate, fill = model)) +
      geom_bar(stat = "identity", position = "dodge") +
      coord_flip() +
      geom_text(aes(label = round(estimate, 3)), hjust = -0.2, position = position_dodge(width = 0.9)) +
      theme_grey(base_size = 16) +
      labs(x = "Group", y = metric, title = paste("Model performance across groups by", group)) 
    
    
  } else {
    
    ggplot(aes(x = reorder(group, estimate), y = estimate, fill = group)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      geom_text(aes(label = round(estimate, 3)), hjust = -0.2, position = position_dodge(width = 0.9)) +
      theme_grey(base_size = 16) +
      labs(x = "Group", y = metric, title = paste("Model performance across groups by", group)) 
    
  }
  
}


plot_protected_metrics = function(protected_metrics, protected = NA, 
                                  display_metric = NA) {
  
  metrics_filtered = protected_metrics %>% 
    filter(str_detect(protected_feature, {{protected}})) %>% 
    clean_names() %>% 
    filter(metric == {{display_metric}}) %>% 
    dplyr::select(model, protected_feature, group, metric, estimate)
  
  models = metrics_filtered %>% 
    distinct(model) %>% 
    pull()
  
  if (display_metric %in% c("rmse", "mae", "mse", "rse", "mape", "smape")) {
    
    if (length(models) > 1) {
      
      metrics_filtered %>% 
        ggplot(aes(x = reorder(group, -estimate), y = estimate, fill = model)) +
        geom_bar(stat = "identity", position = "dodge") +
        coord_flip() +
        geom_text(size = 9, 
                  aes(label = round(estimate, 3)), 
                  hjust = -0.2, position = position_dodge(width = 0.9)) +
        ylim(0, 1) +
        # theme_grey(base_size = 16) +
        labs(x = "Protected Groups",, y = display_metric, 
             title = paste("Performance across groups for", protected)) 
      
      
    } else {
      
      metrics_filtered %>% 
        ggplot(aes(x = reorder(group, -estimate), y = estimate)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        geom_text(size = 8, aes(label = round(estimate, 3)),
                  hjust = -0.2, position = position_dodge(width = 0.9)) +
        ylim(0, 1) +
        # theme_grey(base_size = 16) +
        labs(x = "Protected Groups", y = display_metric, 
             title = paste("Performance across groups for", protected)) 
      
    }
    
  } else {
    
    if (length(models) > 1) {
      
      metrics_filtered %>% 
        ggplot(aes(x = reorder(group, estimate), y = estimate, fill = model)) +
        geom_bar(stat = "identity", position = "dodge") +
        coord_flip() +
        geom_text(size = 9, aes(label = round(estimate, 3)),
                  hjust = -0.2, position = position_dodge(width = 0.9)) +
        # theme_grey(base_size = 16) +
        ylim(0, 1) +
        labs(x = "Protected Groups", y = display_metric, 
             title = paste("Performance across groups for", protected)) 
      
      
    } else {
      
      metrics_filtered %>% 
        ggplot(aes(x = reorder(group, estimate), y = estimate)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        geom_text(size = 9, aes(label = round(estimate, 3)),
                  hjust = -0.2, position = position_dodge(width = 0.9)) +
        # theme_grey(base_size = 16) +
        ylim(0, 1) +
        labs(x = "Protected Groups", y = display_metric, 
             title = paste("Performance across groups for", protected)) 
      
    }
    
  }
  
}


plot_error_direction = function(df, mode, display_feature, false_positive, model, target) {
  
  if (class(df) == "list") {
    
    df_raw = list()
    for (i in 1:length(model)) {
      
      df_raw[[i]] = df[[i]] %>% 
        mutate(model = model[[i]]) %>% 
        relocate(model)
      
    }
    
    df = bind_rows(df_raw)
    
    raw_frame = df %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame = raw_frame %>%
      dplyr::select(all_of(target))
    
    if (mode == "classification") {
      
      score_frame_raw = raw_frame %>% 
        convert_preds(target)
      
      score_frame = score_frame_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      if (false_positive == TRUE) {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fp_ratio), fp_ratio, fill = model)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(
            size = 9,
            aes(y = fp_ratio + 0.7*sign(fp_ratio), label = round(fp_ratio, 2), 
                group = model), 
            position = position_dodge(width = 1),
            inherit.aes = TRUE) +
          labs(x = "Protected Groups", y = "False Positive Rate",
               title = paste("False Positive Rate across groups for", display_feature))
        
      } else {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fn_ratio), fn_ratio, fill = model)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(
            size = 9,
            aes(y = fn_ratio + 0.7*sign(fn_ratio), label = round(fn_ratio, 2), 
                group = model), 
            position = position_dodge(width = 1),
            inherit.aes = TRUE) +
          labs(x = "Protected Groups", y = "False Negative Rate",
               title = paste("False Negative Rate across groups for", display_feature))
        
      }
      
    } else if (mode == "regression") {
      
      print("Not yet ready")
      
    } else {
      
      abort("mode requires specifying either 'classification' or 'regression' depending upon the type of model ran")
      
    }
    
    
  } else {
    
    df = df %>% 
      mutate(model = model) %>% 
      relocate(model)
    
    raw_frame = df %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame = raw_frame %>%
      dplyr::select(all_of(target))
    
    if (mode == "classification") {
      
      score_frame_raw = raw_frame %>% 
        convert_preds(target)
      
      score_frame = score_frame_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      if (false_positive == TRUE) {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fp_ratio), fp_ratio, fill = model)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(
            size = 9,
            aes(y = fp_ratio + 0.7*sign(fp_ratio), label = round(fp_ratio, 2), 
                group = model), 
            position = position_dodge(width = 1),
            inherit.aes = TRUE) +
          labs(x = "Protected Groups", y = "False Positive Rate",
               title = paste("False Positive Rate across groups for", display_feature))
        
      } else {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fn_ratio), fn_ratio, fill = model)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(
            size = 9,
            aes(y = fn_ratio + 0.7*sign(fn_ratio), label = round(fn_ratio, 2), group = model), 
            position = position_dodge(width = 1),
            inherit.aes = TRUE) +
          labs(x = "Protected Groups", y = "False Negative Rate",
               title = paste("False Negative Rate across groups for", display_feature))
        
      }
      
    } else if (mode == "regression") {
      
      print("Not yet ready")
      
    } else {
      
      abort("mode requires specifying either 'classification' or 'regression' depending upon the type of model ran")
      
    }
    
  }
  
}

# add predictions from parsnip::predict to an input dataframe
add_preds = function(data, preds, model_mode, threshold = NA) {
  
  if (model_mode == "classification") {
    
    if (is.na(threshold)) {
      
      data %>% 
        bind_cols(preds) %>% 
        clean_names() %>% 
        mutate(pred_class = factor(ifelse(pred_1 > pred_0, 1, 0), levels = c("0", "1")))
      
    } else {
      
      data %>% 
        bind_cols(preds) %>% 
        clean_names() %>% 
        mutate(pred_class = factor(ifelse(pred_1 > threshold, 1, 0)))
      
    }
    
  } else if (model_mode == "regression") {
    
    data %>% 
      bind_cols(preds) %>% 
      clean_names()
    
  } else {
    
    abort("model_mode argument only accepts values 'regression' or 'classification'")
    
  }
  
}


get_iml_preds = function(fits, data, target) {
  lapply(fits, function(x) Predictor$new(x, data = as_tibble(data) %>% dplyr::select(-target), 
                                         y = as_tibble(data) %>% pull(target),
                                         class = ".pred_1",
                                         type = "prob"))
}


auc_error = function(actual, predicted) 1 - Metrics::auc(actual, predicted)


plot_permutation_importance = function(preds, model_names, mode = NA, metric = NA) {
  
  if (mode == "classification") {
    
    if (is.na(metric) | metric == "auc_error" | metric == "auc") {
      
      imps = lapply(preds, function(x) FeatureImp$new(x, loss = auc_error))
      
      model_names = names(imps)
      
      smol_imps = map2(imps, model_names, function(x, y) x$results %>% top_n(20) %>% as_tibble() %>% 
                         mutate(model_name = y)) %>%
        bind_rows() %>% 
        filter(feature != 'race_protected')
      
      
      ggplot(smol_imps, aes(importance, reorder(feature, importance), 
                            group = model_name, color = model_name)) + 
        geom_point(size = 7, position = position_dodge(1)) +
        geom_errorbarh(aes(xmin = importance.05, xmax = importance.95), size = 1.75,
                       position = position_dodge(1)) +
        labs(x = paste("Importance measured by 1 - AUC"), y = "Feature", 
             title = paste("Permutation Feature Importance"))
      
    } else if (metric %in% c("ce")) {
      
      # imps = lapply(preds, function(x) FeatureImp$new(x, loss = metric)) 
      # smol_imps = lapply(imps, function(x) x$results %>% top_n(20))
      # global_plots = lapply(smol_imps, function(x) ggplot(x, aes(importance, reorder(feature, importance))) + 
      #                         geom_point(size = 3) +
      #                         geom_errorbarh(aes(xmin = importance.05, xmax = importance.95), size = 0.3))
      # imp_plots = list()
      # for (i in 1:length(preds)) {
      #   imp_plots[[i]] = global_plots[[i]] + 
      #     labs(x = paste("Importance measured by", metric), y = "Feature", 
      #          title = paste("Permutation Feature importance for", model_names[[i]])) #+
      #   # theme_grey(base_size = 16)
      
      abort("not yet updated")
      
    } else {
      
      abort("supported metric arguments for classification are 'ce' or 'auc_error'" )
      
    }
    
  } else if (mode == "regression") {
    
    if (is.na(metric)) {
      
      imps = lapply(preds, function(x) FeatureImp$new(x, loss = "rmse")) 
      smol_imps = lapply(imps, function(x) x$results %>% top_n(20))
      global_plots = lapply(smol_imps, function(x) ggplot(x, aes(importance, reorder(feature, importance))) + 
                              geom_point(size = 3) +
                              geom_errorbarh(aes(xmin = importance.05, xmax = importance.95), size = 0.3))
      imp_plots = list()
      for (i in 1:length(preds)) {
        imp_plots[[i]] = global_plots[[i]] + 
          labs(x = paste("Importance measured by rmse"), y = "Feature", 
               title = paste("Permutation Feature Importance", model_names[[i]])) #+
        # theme_grey(base_size = 16)
      }
      
      imp_plots
      
    } else if (metric %in% c("rmse", "mae", "mse", "rse", "mape", "smape")) {
      
      imps = lapply(preds, function(x) FeatureImp$new(x, loss = metric)) 
      smol_imps = lapply(imps, function(x) x$results %>% top_n(20))
      global_plots = lapply(smol_imps, function(x) ggplot(x, aes(importance, reorder(feature, importance))) + 
                              geom_point(size = 3) +
                              geom_errorbarh(aes(xmin = importance.05, xmax = importance.95), size = 0.3))
      imp_plots = list()
      
      for (i in 1:length(preds)) {
        imp_plots[[i]] = global_plots[[i]] + 
          labs(x = paste("Importance measured by", metric), y = "Feature", 
               title = paste("Permutation Feature importance for", model_names[[i]])) #+
        # theme_grey(base_size = 16)
      }
      
    } else {
      
      abort("supported metric arguments for regression are 'rmse', 'mae', 'mase'")
      
    }
    
  } else {
    
    abort("specify whether the underlying model is type 'classification' or 'regression' in the mode argument")
    
  }
  
}


plot_global_interp = function(preds, model_names, display_feature = NULL) {
  
  pdp_ice_data = lapply(preds, function(x) FeatureEffects$new(x, method = "pdp+ice", features = display_feature))
  pdp_ice_data_cleaned = list()
  for (i in 1:length(pdp_ice_data)) { 
    pdp_ice_data_cleaned[[i]] = pdp_ice_data[[i]]$results %>% 
      data.frame() %>% 
      as_tibble() %>% 
      dplyr::select(1:4) %>% 
      dplyr::rename(feature_val = 1,
                    y_hat = 2,
                    type = 3,
                    id = 4) %>% 
      arrange(feature_val) %>% 
      mutate(model = model_names[[i]]) 
    
  }
  
  pdp_ice_data_cleaned %>% 
    bind_rows() %>% 
    filter(type == "pdp") %>% 
    ggplot(aes(feature_val, y_hat)) + 
    geom_line(mapping = aes(feature_val, y_hat, group = model, color = model), size = 2) +
    ylim(0, 1) +
    labs(x = "Feature Value", y = "Probability of recidivism", 
         title = paste("PDP Plot for models on Feature", display_feature))
  
} 


get_observations = function(iml_pred, num_obs) {
  
  iml_pred$data$X %>% 
    as_tibble() %>% 
    group_by(race_protected) %>% 
    group_split() %>% 
    # map(dplyr::select, -race_protected) %>% 
    purrr::map(sample_n, num_obs)
  
}

plot_shapley_values = function(iml_pred, obs) {
  
  obs_ids = obs %>% 
    mutate(race_protected = as.character(race_protected)) %>% 
    pull(race_protected)
  
  mod_shaps = list()
  for (i in 1:nrow(obs)) {
    
    mod_shaps[[i]] = Shapley$new(iml_pred, x.interest = obs %>% slice(i))
    
  }
  
  map2(mod_shaps, obs_ids, function(x, y) as_tibble(x$results) %>% mutate(race = y)) %>%
    bind_rows() %>%
    filter(!(feature %in% c("sex_protected", "race_protected", "age_cat_protected"))) %>%
    relocate(race, everything()) %>%
    ggplot(aes(feature, phi, fill = race)) +
    geom_boxplot() + 
    # theme_grey(base_size = 16) +
    coord_flip() +
    labs(x = "Feature", y = "Feature contribution to prediction",
         title = "Distribution of Shapley Values for race")
  
} 


rm_period = function(x) {
  str_remove(x, "^\\.")
}


convert_preds = function(raw_frame, target) {
  
  raw_frame %>% 
    group_by(model, protected_feature, group) %>% 
    conf_mat({{target}}, pred_class) %>% 
    mutate(conf_mat = purrr::map(conf_mat, tidy)) %>%
    unnest(conf_mat) %>% 
    ungroup() %>% 
    mutate(name = case_when(
      name == "cell_1_1" ~ "TN",
      name == "cell_1_2" ~ "FN",
      name == "cell_2_1" ~ "FP",
      name == "cell_2_2" ~ "TP",
    )) %>% 
    pivot_wider(names_from = name,
                values_from = value)
  
}


fairness_framer = function(df, privileged_class, target, targ_frame, mode) {
  
  if (mode == "classification") {
    
    score_frame_raw = df %>% 
      convert_preds(target)
    
    frame_privileged = score_frame_raw %>% 
      filter(str_detect(group, privileged_class)) %>% 
      mutate(p_demographic_parity = (TP+FP)) %>% 
      mutate(p_equal_opportunity = (TP)/(TP+FP)) %>% 
      mutate(p_spec = (TN)/(TN+FP)) %>% 
      mutate(p_error_rate = (FP+FN)/(TP+FP+TN+FN)) %>% 
      mutate(p_accuracy = ((TP+TN)/(TP+FP+TN+FN))) %>% 
      mutate(p_FDR = (FP)/(TP+FP)) %>% 
      mutate(p_FOR = (FN)/(TN+FN)) %>% 
      mutate(p_tpr = ((TP)/(TP+FP))) %>% 
      mutate(p_fpr = ((FP)/(FP+TN))) %>% 
      mutate(p_fnr = ((FN)/(FN+TP))) %>%
      mutate(p_tnr = ((TN)/(TN+FP))) %>%
      dplyr::select(-c(FN, FP, TN, TP, group))
    
    frame_final = score_frame_raw %>% 
      left_join(frame_privileged, by = c(
        "model" = "model",
        "protected_feature" = "protected_feature"
      )) %>% 
      mutate(raw_demographic_parity = (TP+FP)) %>% 
      mutate(raw_equal_opportunity = (TP)/(TP+FP)) %>% 
      mutate(raw_spec = (TN)/(TN+FP)) %>% 
      mutate(raw_error_rate = (FP+FN)/(TP+FP+TN+FN)) %>% 
      mutate(raw_accuracy = (TP+TN)/(TP+FP+TN+FN)) %>% 
      mutate(raw_FDR = (FP)/(TP+FP)) %>% 
      mutate(raw_FOR = (FN)/(TN+FN)) %>% 
      mutate(raw_tpr = ((TP)/(TP+FN))) %>% 
      mutate(raw_fpr = ((FP)/(FP+TN))) %>% 
      mutate(raw_fnr = ((FN)/(FN+TP))) %>%
      mutate(raw_tnr = ((TN)/(TN+FP))) %>%
      mutate(demographic_parity = (raw_demographic_parity - p_demographic_parity)/(p_demographic_parity)*100) %>% 
      mutate(equal_opportunity = (raw_equal_opportunity - p_equal_opportunity)/(p_equal_opportunity )*100) %>% 
      mutate(error_rate = (raw_error_rate - p_error_rate)/(p_error_rate)*100) %>% 
      mutate(accuracy = (raw_accuracy - p_accuracy)/(p_accuracy)*100) %>% 
      mutate(tpr = (raw_tpr - p_tpr)/(p_tpr)*100) %>% 
      mutate(fpr = (raw_fpr - p_fpr)/(p_fpr)*100) %>%
      mutate(tnr = (raw_tnr - p_tnr)/(p_tnr)*100) %>% 
      mutate(fnr = (raw_fnr - p_fnr)/(p_fnr)*100) %>% 
      mutate(FOR = (raw_FOR - p_FOR)/(p_FOR)*100) %>% 
      mutate(FDR = (raw_FDR - p_FDR)/(p_FDR)*100) %>% 
      mutate(spec = (raw_spec - p_spec)/(p_spec)*100) %>% 
      mutate(equalized_odds = abs(raw_tpr - p_tpr) + abs(raw_tpr - p_tpr)) %>% 
      mutate(privileged = ifelse(group == privileged_class, TRUE, FALSE)) %>% 
      dplyr::select(-c(p_demographic_parity, p_error_rate, p_accuracy, p_tpr, p_fpr, p_tnr, p_fnr, p_FDR, p_FOR, p_spec,
                       p_equal_opportunity, raw_demographic_parity, raw_error_rate, raw_accuracy, raw_tpr, raw_tnr, raw_spec,
                       raw_equal_opportunity, raw_fpr, raw_fnr, raw_FOR, raw_FDR)) 
    
  } else {
    
    internal_metrics = metric_set(rmse, mae, mase)
    
    score_frame_raw = df %>% 
      group_by(model, protected_feature, group) %>% 
      internal_metrics("assaults", estimate = "pred") %>% 
      rename_with(rm_period) %>% 
      select(-estimator)
    
    
    frame_privileged = score_frame_raw %>% 
      filter(str_detect(group, privileged_class)) %>% 
      dplyr::select(-group) %>% 
      rename_with(rm_period) %>% 
      rename(p_estimate = estimate)
    
    frame_final = score_frame_raw %>% 
      mutate(privileged = ifelse(str_detect(group, privileged_class), TRUE, FALSE)) %>%
      left_join(frame_privileged, by = c(
        "model" = "model",
        "protected_feature" = "protected_feature",
        "metric" = "metric"
      )) %>% 
      mutate(estimate = estimate/p_estimate) %>% 
      select(-p_estimate)
    
  }
  
}


gen_fairness_metrics = function(df, model, target, mode, protected, privileged) {
  
  
  if (class(df) == "list") {
    
    df_raw = list()
    for (i in 1:length(model)) {
      
      df_raw[[i]] = df[[i]] %>% 
        mutate(model = model[[i]]) %>% 
        relocate(model)
      
    }
    
    df = bind_rows(df_raw)
    
    if (mode == "classification") {
      
      # get a list of dataframes for each protected feature
      
      holder = list()
      for (i in 1:length(protected)) {
        
        holder[[i]] = df %>% 
          dplyr::select(matches(c(protected[[i]], "pred_|model", target)))
        
      }
      
      # make the protected feature a value in column (group) rather than its own column
      
      raw_frames = purrr::map(holder, function(x) 
        x %>% 
          pivot_longer(cols = matches("_protected"),
                       names_to = "protected_feature", 
                       values_to = "group") %>% 
          relocate(protected_feature, group, everything()))
      
      # get target variable values
      
      targ_frame = raw_frames[[1]] %>%
        dplyr::select(all_of(target))
      
      # calculate confusion matrix results and fairness metrics, pivot so one metric per row
      
      purrr::map2(raw_frames, privileged, fairness_framer, target, targ_frame, mode) %>% 
        bind_rows() %>% 
        dplyr::select(-c(FN, FP, TN, TP)) %>% 
        dplyr::relocate(model, privileged, everything()) %>% 
        pivot_longer(cols = c(equalized_odds, equal_opportunity, spec, demographic_parity, error_rate,
                              accuracy, tpr, fpr, tnr, fnr, FDR, FOR),
                     names_to = "metric",
                     values_to = "estimate")
      
      
    } else if (mode == "regression") {
      
      holder = list()
      for (i in 1:length(protected)) {
        
        holder[[i]] = df %>% 
          dplyr::select(matches(c("_protected|pred|model", target))) %>% 
          dplyr::select(matches(c(protected[[i]], "pred|model", target)))
        
      }
      
      
      raw_frames = purrr::map(holder, function(x) 
        x %>% 
          pivot_longer(cols = matches("_protected"),
                       names_to = "protected_feature", 
                       values_to = "group") %>% 
          relocate(protected_feature, group, everything()))
      
      targ_frame = raw_frames[[1]] %>%
        dplyr::select(all_of(target))
      
      purrr::map2(raw_frames, privileged, fairness_framer, target, targ_frame, mode, val_interest) %>%
        bind_rows() %>%
        dplyr::relocate(model, privileged, everything()) 
      
    } else {
      
      abort("mode requires entering a value of 'classification' or 'regression'")
      
    }
    
  } else {
    
    df = df %>% 
      mutate(model = model) %>% 
      relocate(model)
    
    if (mode == "classification") {
      
      # get a list of dataframes for each protected feature
      
      holder = list()
      for (i in 1:length(protected)) {
        
        holder[[i]] = df %>% 
          dplyr::select(matches(c(protected[[i]], "pred_|model", target)))
        
      }
      
      # make the protected feature a value in column (group) rather than its own column
      
      raw_frames = purrr::map(holder, function(x) 
        x %>% 
          pivot_longer(cols = matches("_protected"),
                       names_to = "protected_feature", 
                       values_to = "group") %>% 
          relocate(protected_feature, group, everything()))
      
      # get target variable values
      
      targ_frame = raw_frames[[1]] %>%
        dplyr::select(all_of(target))
      
      # calculate confusion matrix results and fairness metrics, pivot so one metric per row
      
      purrr::map2(raw_frames, privileged, fairness_framer, target, targ_frame, mode) %>% 
        bind_rows() %>% 
        dplyr::select(-c(FN, FP, TN, TP)) %>% 
        dplyr::relocate(model, privileged, everything()) %>% 
        pivot_longer(cols = c(equalized_odds, equal_opportunity, spec, demographic_parity, error_rate,
                              accuracy, tpr, fpr, tnr, fnr, FDR, FOR),
                     names_to = "metric",
                     values_to = "estimate")
      
      
    } else if (mode == "regression") {
      
      holder = list()
      for (i in 1:length(protected)) {
        
        holder[[i]] = df %>% 
          dplyr::select(matches(c("_protected|pred|model", target))) %>% 
          dplyr::select(matches(c(protected[[i]], "pred|model", target)))
        
      }
      
      
      raw_frames = purrr::map(holder, function(x) 
        x %>% 
          pivot_longer(cols = matches("_protected"),
                       names_to = "protected_feature", 
                       values_to = "group") %>% 
          relocate(protected_feature, group, everything()))
      
      targ_frame = raw_frames[[1]] %>%
        dplyr::select(all_of(target))
      
      purrr::map2(raw_frames, privileged, fairness_framer, target, targ_frame, mode, val_interest) %>%
        bind_rows() %>%
        dplyr::relocate(model, privileged, everything()) 
      

    } else {
      
      abort("mode requires entering a value of 'classification' or 'regression'")
      
    }
    
  }
  
}


plot_fairness_metrics = function(group_metrics, display_feature, metric) {
  
  group_levels = group_metrics %>% 
    filter(str_detect(protected_feature, display_feature)) %>% 
    summarize(num = n_distinct(group)) %>% 
    pull(num)
  
  privileged = group_metrics %>% 
    filter(str_detect(protected_feature, display_feature)) %>% 
    filter(privileged == TRUE) %>% 
    distinct(group) %>% 
    mutate(group = as.character(group)) %>% 
    pull()
  
  if (group_levels == 2) {
    
    metrics_filtered = group_metrics %>% 
      filter(str_detect(protected_feature, display_feature)) %>% 
      filter(privileged == FALSE) %>% 
      filter(metric == {{metric}}) %>% 
      dplyr::select(model, privileged, protected_feature, group, metric, estimate)
    
    models = metrics_filtered %>% 
      distinct(model) 
    
    if (nrow(models) > 1) {
      
      metrics_filtered %>% 
        ggplot(aes(x = reorder(group, estimate), y = estimate, fill = model)) +
        geom_bar(stat = "identity", position = "dodge") +
        coord_flip() +
        # geom_text(aes(label = paste0(round(estimate*100, 2), "%")), hjust = -0.2, position = position_dodge(width = 0.9)) +
        geom_text(size = 9,
                  aes(y = estimate + 0.015*sign(estimate), label = paste0(round(estimate, 2), "%")), 
                  position = position_dodge(width = 0.9)) +
        # theme_grey(base_size = 16) +
        labs(x = "Protected Groups",  y = paste("Difference in", metric, "relative to privileged group", privileged),
             title = paste("Model fairness across", display_feature, "groups by", metric)) 
      
    } else {
      
      metrics_filtered %>%
        ggplot(aes(x = reorder(group, estimate), y = estimate)) +
        geom_bar(stat = "identity", position = "dodge") +
        coord_flip() +
        ylim(-3, 3) +
        # geom_text(aes(label = paste0(round(estimate*100, 2), "%")), hjust = -0.2, position = position_dodge(width = 0.9)) +
        geom_text(size = 9,
                  aes(y = estimate + 0.015*sign(estimate), label = paste0(round(estimate, 2), "%")), 
                  position = position_dodge(width = 0.9)) +
        # theme_grey(base_size = 16) +
        labs(x = "Protected Groups", y = paste("Difference in", metric, "relative to privileged group", privileged),
             title = paste("Model fairness across", display_feature, "groups by", metric))
      
    }
    
    
  } else if (group_levels > 2) {
    
    metrics_filtered = group_metrics %>% 
      filter(str_detect(protected_feature, display_feature)) %>% 
      filter(privileged == FALSE) %>% 
      filter(metric == {{metric}}) %>% 
      dplyr::select(model, privileged, group, metric, estimate)
    
    models = metrics_filtered %>% 
      distinct(model) 
    
    metrics_filtered %>% 
      ggplot(aes(x = reorder(group, -estimate), y = estimate, fill = model)) +
      geom_bar(stat = "identity", position = "dodge") +
      coord_flip() +
      # geom_text(aes(label = paste0(round(estimate*100, 2), "%")), hjust = -0.2, position = position_dodge(width = 0.9)) +
      geom_text(size = 9,
                aes(y = estimate + 0.015*sign(estimate), label = paste0(round(estimate, 2), "%")), 
                position = position_dodge(width = 0.9)) +
      # theme_grey(base_size = 16) +
      labs(x = "Protected Groups", y = paste("Difference in", metric, "relative to privileged group", privileged), 
           title = paste("Model fairness across", display_feature, "groups by", metric)) 
    
  } else {
    
    abort("ensure that the examined group contains at least 2 unique sub-groups")
    
  } 
  
}

per_group_thresholding = function(df, target, prob_event, threshold_sequence, protected, metrics) {
  
  result_list = list()
  for (j in 1:length(threshold_sequence)) {
    
    target_vec = df %>% 
      dplyr::select(target) %>% 
      pull()
    
    estimate_vec = df %>% 
      mutate(pred_class = factor(ifelse(df %>% dplyr::select(prob_event) > threshold_sequence[[j]], 1, 0),
                                 levels = c("0", "1"))) %>% 
      pull(pred_class)
    
    result_list[[j]] = df %>% 
      metrics(truth = target_vec, estimate = estimate_vec) %>%
      mutate(thresh = threshold_sequence[[j]]) %>% 
      mutate(protected_group = protected)
    
  }
  
  result_list
  
}

plot_model_thresholds = function(pred_data, target, prob_event, protected, metrics, threshold_sequence) {
  
  result_list = list()
  
  protected_labels = pred_data %>% 
    dplyr::distinct(across(all_of(protected))) %>% 
    dplyr::arrange(across(all_of(protected))) %>% 
    pull(protected) 
  
  df_list = pred_data %>% 
    dplyr::select(all_of(c(protected, target, prob_event))) %>% 
    dplyr::arrange(across(all_of(protected))) %>% 
    dplyr::group_by(across(all_of(protected))) %>% 
    group_split()
  
  slug_tibble = tibble(df = df_list,
                       target = list(target),
                       prob_event = list(prob_event),
                       threshold_sequence = list(threshold_sequence),
                       protected = protected_labels,
                       metrics = list(metrics))
  
  result_list = pmap(slug_tibble, per_group_thresholding) %>% 
    bind_rows()
  
  result_list %>%
    bind_rows() %>%
    ggplot(aes(thresh, .estimate)) +
    geom_line(aes(color = .metric), size = 2) +
    facet_wrap(~protected_group) +
    labs(x = "Probability threshold for event", y = "Metric estimate", 
         title = "Plot of Performance Metric Tradeoffs by Threshold")
  
}

gen_optimal_thresholds = function(df, protected, target, prob_event) {
  
  protected_labels = df %>% 
    dplyr::distinct(across(all_of(protected))) %>% 
    dplyr::arrange(across(all_of(protected))) %>% 
    pull(protected)
  
  df_list = df %>% 
    dplyr::select(all_of(c(protected, target, prob_event))) %>% 
    dplyr::arrange(across(all_of(protected))) %>% 
    dplyr::group_by(across(all_of(protected))) %>% 
    group_split()
  
  threshold_frame = purrr::map(df_list, function(x)
    x %>%
      roc_curve(.data[[target]], .data[[prob_event]]) %>%
      mutate(j_stat = sensitivity + specificity - 1) %>%
      arrange(-j_stat) %>%
      top_n(1) %>% 
      dplyr::select(j_stat) 
  ) %>% 
    bind_rows() %>% 
    mutate(group = protected_labels) %>% 
    relocate(group)
  
  return(threshold_frame)
  
}

per_group_thresholds = function(df_group, threshold_list, prob_event) {
  
  df_group %>% 
    mutate(pred_class = factor(ifelse(df_group %>% dplyr::select(all_of(prob_event)) > threshold_list, 1, 0), 
                               levels = c("0", "1")))
  
}


gen_mitigated_preds = function(df, threshold_frame = NA, threshold_list = NA, protected, prob_event) {
  
  if (is.na(threshold_frame) & is.na(threshold_list)) {
    
    stop("need to provide a tibble of thresholds from gen_optimal_thresholds or a list of numerics corresponding
         to desired thresholds for each group")
    
  } else if (!is.na(threshold_frame) & is.na(threshold_list)) {
    
    threshold_list = threshold_frame %>% 
      pull(j_stat)
    
    df %>% 
      group_by(across(all_of(protected))) %>% 
      group_split() %>% 
      map2(threshold_list, per_group_thresholds, prob_event) %>% 
      bind_rows()
    
  } else if (is.na(threshold_frame) & !is.na(threshold_list)) {
    
    df %>% 
      dplyr::arrange(across(all_of(protected))) %>% 
      group_by(across(all_of(protected))) %>% 
      group_split() %>% 
      map2(threshold_list, per_group_thresholds, prob_event) %>% 
      bind_rows()
    
  } else {
    
    stop("provide a valid tibble for threshold_frame or list for threshold_list")
    
  }
  
}

plot_fairness_comparison = function(fairness_metrics, opt_fairness_metrics, model, display_feature, metric) {
  
  first_set = fairness_metrics %>% 
    mutate(data_type = "original")
  
  second_set = opt_fairness_metrics %>% 
    mutate(data_type = "new")
  
  group_metrics = bind_rows(first_set, second_set)
  
  group_levels = group_metrics %>% 
    filter(str_detect(protected_feature, display_feature)) %>% 
    summarize(num = n_distinct(group)) %>% 
    pull(num)
  
  privileged = group_metrics %>% 
    filter(str_detect(protected_feature, display_feature)) %>% 
    filter(privileged == TRUE) %>% 
    distinct(group) %>% 
    mutate(group = as.character(group)) %>% 
    pull()
  
  if (group_levels == 2) {
    
    metrics_filtered = group_metrics %>% 
      filter(str_detect(protected_feature, display_feature)) %>% 
      filter(privileged == FALSE) %>% 
      filter(metric == {{metric}}) %>% 
      filter(model == {{model}}) %>% 
      dplyr::select(model, data_type, privileged, protected_feature, group, metric, estimate)
    
    metrics_filtered %>% 
      ggplot(aes(x = reorder(group, estimate), y = estimate, fill = data_type)) +
      geom_bar(stat = "identity", position = "dodge") +
      coord_flip() +
      # geom_text(aes(label = paste0(round(estimate*100, 2), "%")), hjust = -0.2, position = position_dodge(width = 0.9)) +
      geom_text(aes(y = estimate + 0.015*sign(estimate), label = paste0(round(estimate, 2), "%")), 
                position = position_dodge(width = 0.9)) +
      labs(x = "Protected groups",  y = paste("Difference in", metric, "relative to privileged group", privileged),
           title = paste("Model fairness across", display_feature, "groups by", metric)) 
    
    
  } else if (group_levels > 2) {
    
    metrics_filtered = group_metrics %>% 
      filter(str_detect(protected_feature, display_feature)) %>% 
      filter(privileged == FALSE) %>% 
      filter(metric == {{metric}}) %>% 
      filter(model == {{model}}) %>% 
      dplyr::select(model, data_type, privileged, group, metric, estimate)
    
    metrics_filtered %>% 
      ggplot(aes(x = reorder(group, -estimate), y = estimate, fill = data_type)) +
      geom_bar(stat = "identity", position = "dodge") +
      coord_flip() +
      # geom_text(aes(label = paste0(round(estimate*100, 2), "%")), hjust = -0.2, position = position_dodge(width = 0.9)) +
      geom_text(aes(y = estimate + 0.015*sign(estimate), label = paste0(round(estimate, 2), "%")), 
                position = position_dodge(width = 0.9)) +
      labs(x = "Protected groups", y = paste("Difference in", metric, "relative to privileged group", privileged), 
           title = paste("Change in", metric, "after calibrating prediction thresholds")) 
    
    
    
  } else {
    
    abort("ensure that the examined group contains at least 2 unique sub-groups")
    
  } 
  
}


plot_error_comparison = function(df_old, df_new,  mode, display_feature, false_positive, model, target) {
  
  if (class(df_old) == "list" & class(df_new) == "list") {
    
    df_old_raw = list()
    for (i in 1:length(model)) {
      
      df_old_raw[[i]] = df_old[[i]] %>% 
        mutate(model = model[[i]]) %>% 
        relocate(model)
      
    }
    
    df_old = bind_rows(df_old_raw) %>% 
      filter(model == {{model}}) %>% 
      mutate(data_type = "old")
    
    df_new_raw = list()
    for (i in 1:length(model)) {
      
      df_new_raw[[i]] = df_new[[i]] %>% 
        mutate(model = model[[i]]) %>% 
        relocate(model)
      
    }
    
    df_new = bind_rows(df_new_raw) %>% 
      filter(model == {{model}}) %>% 
      mutate(data_type = "new")
    
    raw_frame_old = df_old %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame_old = raw_frame_old %>%
      dplyr::select(all_of(target))
    
    raw_frame_new = df_new %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame_new = raw_frame_new %>%
      dplyr::select(all_of(target))
    
    if (mode == "classification") {
      
      score_frame_old_raw = raw_frame_old %>% 
        convert_preds(target) %>% 
        mutate(data_type = "old")
      
      score_frame_old = score_frame_old_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      score_frame_new_raw = raw_frame_new %>% 
        convert_preds(target) %>% 
        mutate(data_type = "new")
      
      score_frame_new = score_frame_new_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      score_frame_bound = bind_rows(score_frame_old, score_frame_new)
      
      if (false_positive == TRUE) {
        
        score_frame_bound %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fp_ratio), fp_ratio, fill = data_type)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(aes(y = fp_ratio + 0.7*sign(fp_ratio), label = round(fp_ratio, 2)), 
                    position = position_dodge(width = 0.9)) +
          labs(x = "Protected groups", y = "False Positive Rate",
               title = paste("False Positive Rate by protected feature", display_feature))
        
      } else {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fn_ratio), fn_ratio, fill = data_type)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(aes(y = fn_ratio + 0.7*sign(fn_ratio), label = round(fn_ratio, 2)), 
                    position = position_dodge(width = 0.9)) +
          labs(x = paste("Protected groups"), y = "False Negative Rate",
               title = paste("False Negative Rate by protected feature", display_feature))
        
      }
      
    } else if (mode == "regression") {
      
      print("Not yet ready")
      
    } else {
      
      abort("mode requires specifying either 'classification' or 'regression' depending upon the type of model ran")
      
    }
    
  } else if (any(class(df_old) == "data.frame") & any(class(df_new) == "data.frame")) {
    
    df_old = df_old %>% 
      mutate(model = model) %>% 
      relocate(model)
    
    df_new = df_new %>% 
      mutate(model = model) %>% 
      relocate(model)
    
    raw_frame_old = df_old %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame_old = raw_frame_old %>%
      dplyr::select(all_of(target))
    
    raw_frame_new = df_new %>% 
      pivot_longer(cols = matches("_protected"),
                   names_to = "protected_feature",
                   values_to = "group") %>% 
      relocate(protected_feature, group, everything())
    
    targ_frame_new = raw_frame_new %>%
      dplyr::select(all_of(target))
    
    if (mode == "classification") {
      
      score_frame_old_raw = raw_frame_old %>% 
        convert_preds(target) %>% 
        mutate(data_type = "old")
      
      score_frame_old = score_frame_old_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      score_frame_new_raw = raw_frame_new %>% 
        convert_preds(target) %>% 
        mutate(data_type = "new")
      
      score_frame_new = score_frame_new_raw %>% 
        filter(str_detect(protected_feature, display_feature)) %>% 
        mutate(fp_ratio = ((FP)/(FP + TN))*100) %>% 
        mutate(fn_ratio = ((FN)/(FN + TP))*100) %>% 
        dplyr::select(-c(FN, FP, TN, TP)) 
      
      score_frame_bound = bind_rows(score_frame_old, score_frame_new)
      
      if (false_positive == TRUE) {
        
        score_frame_bound %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fp_ratio), fp_ratio, fill = data_type)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(aes(y = fp_ratio + 0.7*sign(fp_ratio), label = round(fp_ratio, 2)), 
                    position = position_dodge(width = 0.9)) +
          labs(x = "Protected groups", y = "False Positive Rate",
               title = paste("False Positive Rate by protected feature", display_feature))
        
      } else {
        
        score_frame %>%
          filter(str_detect(protected_feature, display_feature)) %>%
          ggplot(aes(reorder(group, fn_ratio), fn_ratio, fill = data_type)) +
          geom_bar(stat = "identity", position = "dodge") +
          coord_flip() +
          geom_text(aes(y = fn_ratio + 0.7*sign(fn_ratio), label = round(fn_ratio, 2)), 
                    position = position_dodge(width = 0.9)) +
          labs(x = paste("Protected groups"), y = "False Negative Rate",
               title = paste("False Negative Rate by protected feature", display_feature))
        
      }
      
    } else if (mode == "regression") {
      
      print("Not yet ready")
      
    } else {
      
      abort("mode requires specifying either 'classification' or 'regression' depending upon the type of model ran")
      
    }
    
  }
  
} 


