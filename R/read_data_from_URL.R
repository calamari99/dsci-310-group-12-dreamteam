## Milestone 2:
## Select and clean data:
##
## pulls data from url
## replaces specified columns as categorical factors
## renames column headers to remove spaces
##
## @parmam: url is a "string" of the dataset file, name is the labeled name of the dataset
## @parmam: name is a the name of the dataset
library(readr)

read_data_from_url <- function(url) {
  facebook <<- read_csv2(url) 
  cols <- c("Type", "Category", "Post Month", "Paid", "Post Weekday", "Post Hour")  #set cols to change to categorical %>%
  facebook[cols] <<- lapply(facebook[cols], as.factor)
  name_temp <<- facebook
  name_temp_vec <<- gsub(" ", "_", colnames(facebook))
  colnames(facebook) <<- name_temp_vec
  return(facebook)
}