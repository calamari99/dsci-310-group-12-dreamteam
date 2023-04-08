# author: Enoch Cheung
# date: 2023-04-07

doc <- "
Split data to training/testing/validation sets for unpaid dataset 

Usage: 
  data/facebook.csv --input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     raw data file
--out_dir=<out_dir>   clean data dir
" 
#libraries
library(dplyr)
library(docopt)
library(readr)
library(caTools)

#split constants
set.seed(99)
partitionTrain = 0.8
ratioTrainValidation = 7/8

opt <- docopt(doc)

main <- function(input_dir, out_dir) {
    facebook_clean_unpaid <<- read_delim(input_dir) 
    split <- sample.split(facebook_clean_unpaid$like, SplitRatio = partitionTrain)
    train_val_data_unpaid <- subset(facebook_clean_unpaid, split == TRUE)
    test_set_unpaid <- subset(facebook_clean_unpaid, split == FALSE)

    split <- sample.split(train_val_data_unpaid$like, SplitRatio = ratioTrainValidation)
    train_set_unpaid <- subset(train_val_data_unpaid, split == TRUE)
    val_set_unpaid <- subset(train_val_data_unpaid, split == FALSE)


    # ouput
    file_name_train = "train_set.csv"
    file_name_test = "test_set.csv"

    write_csv(test_set_unpaid, file.path(out_dir, file_name_train))
    write_csv(train_set_unpaid, file.path(out_dir, file_name_test))
    print("Training Data Saved in data folder")
}

# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])