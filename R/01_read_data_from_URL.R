# author: Enoch Cheung
# date: 2023-04-07

doc <- "
Download data from the web into csv file and load libaries.
Usage: 
  R/01_read_data_from_URL.R --url=<url> --out_dir=<out_dir>
Options:
--input_dir=<url>     URL path of data 
--out_dir=<out_dir>   Path to write file on local machine
" 
# set cran mirrpr
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

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
install.packages('caTools')
library(caTools)

opt <- docopt(doc)

main <- function(url,out_dir) {
  facebook <<- read_csv2(url) 
  cols <- c("Type", "Category", "Post Month", "Paid", "Post Weekday", "Post Hour")  #set cols to change to categorical %>%
  facebook[cols] <<- lapply(facebook[cols], as.factor)
  name_temp <<- facebook
  name_temp_vec <<- gsub(" ", "_", colnames(facebook))
  colnames(facebook) <<- name_temp_vec

  #  Save file name and location
  file_name <- "facebook.csv"
  write_csv(facebook, file.path(out_dir, file_name))
}

# call main
main(opt[["--url"]], opt[["--out_dir"]])

