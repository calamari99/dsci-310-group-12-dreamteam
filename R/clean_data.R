## Milestone 2:
## Cleans data by selecting only necessary columns:
## 
##
## First selects all necessary coluumns, removes NA data
## and splits into paid vs unpaid posts before giving a summary of the 
## splits
##
# @ param: facebook = dataset


library(dplyr)
clean_data <- function(facebook) {
  facebook_clean <- dplyr::select(facebook, Type, comment,
                                  like, share, Total_Interactions,
                                  Paid, Lifetime_Post_Total_Impressions,
                                  Lifetime_Post_Total_Reach) %>%
    na.omit(df)
  
  facebook_clean_unpaid <- facebook_clean %>% filter(Paid == 0)
  facebook_clean_paid <- facebook_clean %>% filter(Paid == 1)
  
  # Summary of unpaid posts by type
  unpaid_summary <- facebook_clean_unpaid %>% group_by(Type) %>% 
    summarise(unpaid = n()) 
  
  # Summary of paid posts by type
  paid_summary <- facebook_clean_paid %>% group_by(Type) %>% 
    summarise(paid = n())
  
  print("Table 1. Facebook data summary")
  Reduce(dplyr::full_join, list(unpaid_summary, paid_summary)) %>%
    suppressMessages()
}