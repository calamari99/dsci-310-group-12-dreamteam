# author: Enoch Cheung
# date: 2023-04-08

doc <- "
Take valset and trainset variables and start building model. (i) Pre-tuned (ii) 

Usage: 
  R/06_knn--input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     train/val data
--out_dir=<out_dir>         data dir
" 

main <- function( 

    train_set_unpaid <- readRDS(data/train_set_unpaid.rds)
    val_set_unpaid <- readRDS(data/val_set_unpaid.rds)

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
    saveRDS(unpaid_prediction_accuracy,  file = paste0(out_dir,"/unpaid_prediction_accuracy.rds"))
    print("saved accuracy as variable")
    
)


# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])
