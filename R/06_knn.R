# author: Enoch Cheung
# date: 2023-04-08

# doc <- "
# Take valset and trainset variables and start building model. (i) Pre-tuned (ii) 

# Usage: 
#   R/06_knn--input_dir=<input_dir> --out_dir=<out_dir>
# Options:
# --input_dir=<input_dir>     train/val data
# --out_dir=<out_dir>         data dir
# " 

#libraries
library(readr)
library(docopt)
library(dplyr)
library(ggplot2)
library(tidyr)
library(grid)
library(gridExtra)
library(kknn)
library(repr)
library(cowplot)
library(tidyverse)
library(tidymodels)
library(caTools)

main <- function() {

    train_set_unpaid <- readRDS("data/train_set_unpaid.rds")
    val_set_unpaid <- readRDS("data/val_set_unpaid.rds")

    knn_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = 3) %>%
      set_engine("kknn") %>%
      set_mode("classification")

    unpaid_recipe <- recipe(Type ~ 
                            Lifetime_Post_Total_Reach + Total_Interactions,
                            data = train_set_unpaid) %>%
                        step_scale(all_predictors()) %>%
                        step_center(all_predictors())

    unpaid_fit <- workflow() %>%
        add_recipe(unpaid_recipe) %>%
        add_model(knn_spec) %>%
        fit(data = train_set_unpaid)

    unpaid_val_predicted <- predict(unpaid_fit, val_set_unpaid) %>%
        bind_cols(val_set_unpaid)

    unpaid_prediction_accuracy <- unpaid_val_predicted %>%
        metrics(truth = Type, estimate = .pred_class)

    unpaid_val_predicted %>%
        conf_mat(truth = Type, estimate = .pred_class)
    
    print("06_run")
        # #Save table with prediction accuracy
    # png(
    #     file="/results/04_unpaid_prediction_accuracy.png",
    #     width=8
    #     height=4
    # )

    # print("saved knn table accuracy")

    #save variable
    saveRDS(unpaid_prediction_accuracy,  file = paste0("data/unpaid_prediction_accuracy.rds"))
    print("saved accuracy as variable")


    ## TUNING ######################################################
    unpaid_vfold <- vfold_cv(train_set_unpaid, v = 10, strata = Type)

    unpaid_fit_v2 <- workflow() %>%
        add_recipe(unpaid_recipe) %>%
        add_model(knn_spec) %>%
        fit_resamples(resamples = unpaid_vfold) %>% collect_metrics() %>%
        suppressMessages()

    #save variable
    # saveRDS(unpaid_prediction_accuracy,  file = paste0("data/unpaid_prediction_accuracy.rds"))
    # print("saved accuracy as variable")


    knn_tune <- nearest_neighbor(weight_func = "rectangular", neighbors = tune()) %>%
    set_engine("kknn") %>%
    set_mode("classification") 

    knn_results <- workflow() %>%
        add_recipe(unpaid_recipe) %>%
        add_model(knn_tune) %>%
        tune_grid(resamples = unpaid_vfold, grid = 10) %>% 
        collect_metrics() %>%
        suppressMessages()

    accuracies <- knn_results %>% 
        filter(.metric == "accuracy")

    accuracy_versus_k <- ggplot(accuracies, aes(x = neighbors, y = mean))+
        geom_point() +
        geom_line() +
        labs(x = "Neighbors", y = "Accuracy Estimate",
            title = "Figure 8. K-NN Classification Accuracy by Neighbors") +
        scale_x_continuous(breaks = seq(0, 16, by = 2)) +  # adjusting the x-axis
        scale_y_continuous(limits = c(0.8, 1.0)) + # adjusting the y-axis
        theme(text = element_text(size = 20))

    
    #  Save file 4 name and location
    ggsave(filename = "04_KNN_ACCURACY.png", 
     plot = accuracy_versus_k,
     path = "results", 
     device="png")

    print("figure 04_KNN_ACCURACY saved")
    
}

main()
# # call main
# main(opt[["--input_dir"]], opt[["--out_dir"]])
