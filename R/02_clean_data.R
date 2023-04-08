# author: Enoch Cheung
# date: 2023-04-07

doc <- "
Cleans data by selecting only necessary columns: First selects all necessary coluumns, removes NA data,
and splits into paid vs unpaid posts before giving a summary of the splits

Usage: 
  R/01_read_data_from_URL.R --url=<url> --out_dir=<out_dir>
Options:
--input_dir=<input>     raw data file
--out_dir=<out_dir>   clean data dir
" 
#libraries
library(dplyr)

opt <- docopt(doc)


clean_data <- function(facebook) {
  facebook_clean <<- na.omit(dplyr::select(facebook, Type, comment,
                                  like, share, Total_Interactions,
                                  Paid, Lifetime_Post_Total_Impressions,
                                  Lifetime_Post_Total_Reach))
                      
  
  facebook_clean_unpaid <<- facebook_clean %>% filter(Paid == 0)
  facebook_clean_paid <<- facebook_clean %>% filter(Paid == 1)
  
  # Summary of unpaid posts by type
  unpaid_summary <<- facebook_clean_unpaid %>% group_by(Type) %>% 
    summarise(unpaid = n()) 
  
  # Summary of paid posts by type
  paid_summary <<- facebook_clean_paid %>% group_by(Type) %>% 
    summarise(paid = n())
  
  Reduce(dplyr::full_join, list(unpaid_summary, paid_summary)) %>%
    suppressMessages()

  write_csv(facebook_clean_paid, file.path(out_dir, file_name))
}