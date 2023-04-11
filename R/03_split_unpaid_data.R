# author: Enoch Cheung
# date: 2023-04-07

doc <- "
Split data to training/testing/validation sets for unpaid dataset 

Usage: 
  R/03_split_unpaid_data.R --input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     clean data file
--out_dir=<out_dir>         data dir
" 

# set cran mirror
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

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

print("libraries read")

opt <- docopt(doc)

main <- function(input_dir, out_dir) {
    #split constants
    set.seed(99)
    partitionTrain = 0.8
    ratioTrainValidation = 7/8

    #Read
    facebook_clean_unpaid <<- read_delim(input_dir)
    cols <- c("Type","Paid")

    #change data types
    facebook_clean_unpaid[cols] <- lapply(facebook_clean_unpaid[cols], as.factor)
    name_temp <- facebook_clean_unpaid
    name_temp_vec <- gsub(" ", "_", colnames(facebook_clean_unpaid))
    colnames(facebook_clean_unpaid) <- name_temp_vec

    #split test
    split <- sample.split(facebook_clean_unpaid$like, SplitRatio = partitionTrain)
    train_val_data_unpaid <- subset(facebook_clean_unpaid, split == TRUE)
    test_set_unpaid <- subset(facebook_clean_unpaid, split == FALSE)

    #split train
    split <- sample.split(train_val_data_unpaid$like, SplitRatio = ratioTrainValidation)
    train_set_unpaid <- subset(train_val_data_unpaid, split == TRUE)
    val_set_unpaid <- subset(train_val_data_unpaid, split == FALSE)

    # output
    file_name_train = "train_set.csv"
    file_name_test = "test_set.csv"

    write_csv(test_set_unpaid, file.path(out_dir, file_name_train))
    write_csv(train_set_unpaid, file.path(out_dir, file_name_test))
    print("Training Data Saved in data folder")

    saveRDS(train_set_unpaid,  file = paste0(out_dir,"/train_set_unpaid.rds"))
    saveRDS(val_set_unpaid,  file = paste0(out_dir,"/val_set_unpaid.rds"))


}

# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])