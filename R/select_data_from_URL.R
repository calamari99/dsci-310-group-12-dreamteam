## Milestone 2:
## Select and clean data:
##
## pulls data from url
## replaces specified columns as categorical factors
## renames column headers to remove spaces
##
## @parmam: url is a "string" of the dataset file, name is the labeled name of the dataset
## @parmam: name is a the name of the dataset

read_data_from_url <- function(url,name) {
  name <- read_csv2(url) 
  cols <- c("Type", "Category", "Post Month", "Paid", "Post Weekday", "Post Hour")  #set cols to change to categorical %>%
  name[cols] <- lapply(name[cols], as.factor)
  name_temp <- name
  name_temp_vec <- gsub(" ", "_", colnames(name))
  colnames(name) <- name_temp_vec
  return(name)
}