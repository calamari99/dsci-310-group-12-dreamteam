# author: Enoch Cheung
# date: 2023-04-07

doc <- "

Usage: 
  R/02_clean_data.R --input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     raw data file
--out_dir=<out_dir>         clean data dir
" 
#libraries
library(dplyr)
library(docopt)
library(readr)
#final project library for splits function
devtools::install_github("DSCI-310/dsci-310-group-12-pkg")
library(testpkg)

opt <- docopt(doc)


main <- function(input_dir, out_dir) {
  facebook <- read_csv(input_dir) 
  facebook_clean <- dplyr::select(facebook, Type, comment,
                                  like, share, Total_Interactions,
                                  Paid, Lifetime_Post_Total_Impressions,
                                  Lifetime_Post_Total_Reach) %>%
                                  na.omit()
                      
  
  facebook_clean_unpaid <- facebook_clean %>% filter(Paid == 0)
  facebook_clean_paid <- facebook_clean %>% filter(Paid == 1)

  # Summary of unpaid posts by type

  unpaid_summary <- summariseByCol(facebook_clean_unpaid,"Type")
  paid_summary <- summariseByCol(facebook_clean_unpaid,"Type")
  
  # paid_summary <- facebook_clean_paid %>% group_by(Type) %>% 
  #   summarise(paid = n())

  # unpaid_summary <- facebook_clean_unpaid %>% group_by(Type) %>% 
  #   summarise(unpaid = n()) 
  
  Reduce(dplyr::full_join, list(unpaid_summary, paid_summary)) %>%
    suppressMessages()

  file_name = "facebook_clean.csv"
  write_csv(facebook_clean_unpaid, file.path(out_dir, file_name))
  
}

# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])