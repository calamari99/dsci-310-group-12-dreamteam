# author: Enoch Cheung
# date: 2023-04-07
# Figure 1: Mean number of likes requires train_set_unpaid
# Figure 2: Mean interactions per post requires train_set_unpaid
# Figure 3:Total Reach vs Total Interactions requires train_set_unpaid


doc <- "
Produce figure 1,2,3

Usage: 
  R/04_EDA.R --input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     training set dir
--out_dir=<out_dir>         figure output in results
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
library(caTools)

opt <- docopt(doc)

main <- function(input_dir,out_dir) {
    #read in data
    train_set_unpaid <<- read_delim(input_dir) 

    #summary of unpaid posts
    summ_train_unpaid <- train_set_unpaid %>%
    group_by(Type) %>%
    summarise(
        count = n(),
        mean_comment = mean(comment), 
        median_comment = median(comment), 
        mean_like = mean(like),
        median_like = median(like),
        mean_Total_Interactions = mean(Total_Interactions),
        median_Total_Interactions = median(Total_Interactions),
        mean_share = mean(share),
        median_share = median(share)) %>%
    suppressMessages()

    mean_comment <- summ_train_unpaid$mean_comment
    mean_like <- summ_train_unpaid$mean_like
    mean_Total_Interactions <- summ_train_unpaid$mean_Total_Interactions
    mean_share <- summ_train_unpaid$mean_share
    type <- summ_train_unpaid$Type

    test_df <- data.frame(type,
                        mean_comment,
                        mean_like,
                        mean_share,
                        mean_Total_Interactions)

    # print("Table 5. Mean interactions for different types of posts")
    # test_df

    fb_long <- test_df %>%
    gather("Stat", "Value", -type)

    # print("Table 6. Mean interactions for different types of posts pivoted")
    # fb_long

    filter_mean_like <- fb_long %>%
    filter(Stat == "mean_like") %>%
    arrange(desc(Value))

    # print("Table 7. Mean likes for different types of posts")
    # filter_mean_like

    options(repr.plot.width = 8, repr.plot.height = 6) 

    mean_likes_bar <- ggplot(filter_mean_like, aes(x = type, y = Value, fill = type)) +
        geom_bar(stat = "identity") +
        labs(x = "Post Type", y = "Mean Number of Likes",
            title = "Figure 1. Mean number of likes per post type") +
        theme(text = element_text(size = 20)) 
    

    #  Save file name and location
    file_name <- "01_meanLikesByPostType"
    ggsave(file.path(out_dir, file_name), plot=mean_likes_bar)
}

# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])

