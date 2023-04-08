# author: Enoch Cheung
# date: 2023-04-07

"
Download data from the web into csv file and load libaries.
Usage: R/read_data_from_URL.R --url=<url> --out_dir=<out_dir>
Options:
--url=<url>           URL path of data 
--out_dir=<out_dir>   Path to write file on local machine
" -> doc

# "../data/facebook_data.csv" - output

library(readr)
library(docopt)
options(repr.matrix.max.rows = 8)
suppressPackageStartupMessages(library(docopt))
suppressPackageStartupMessages(library(caTools))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(grid))
suppressPackageStartupMessages(library(gridExtra))
suppressPackageStartupMessages(library(kknn))
suppressPackageStartupMessages(library(repr))
suppressPackageStartupMessages(library(cowplot))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(tidymodels))

opt <- docopt(doc)

main <- function(url,out_dir) {
  url="https://raw.githubusercontent.com/calamari99/Facebook-Post-Predictor/main/data/dataset_Facebook.csv"
  out_dir="../data/facebook_data.csv"
  facebook <<- read_csv2(url) 
  cols <- c("Type", "Category", "Post Month", "Paid", "Post Weekday", "Post Hour")  #set cols to change to categorical %>%
  facebook[cols] <<- lapply(facebook[cols], as.factor)
  name_temp <<- facebook
  name_temp_vec <<- gsub(" ", "_", colnames(facebook))
  colnames(facebook) <<- name_temp_vec
  write_csv(facebook, "../data/facebook_data.csv")

#  Save file location

#
  main(opt[["--url"]], opt[["--out_dir"]])

}


