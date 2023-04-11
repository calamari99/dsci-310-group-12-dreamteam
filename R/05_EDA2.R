# author: Enoch Cheung
# date: 2023-04-07
# Figure 3:Total Reach vs Total Interactions requires train_set_unpaid

doc <- "
produce figure 3

Usage: 
  R/05_EDA2.R --input_dir=<input_dir> --out_dir=<out_dir>
Options:
--input_dir=<input_dir>     clean data file
--out_dir=<out_dir>         result dir
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
 

    #Read
    facebook_clean_unpaid <<- read_delim(input_dir) 

    #function change datatypes
    cols <- c("Type","Paid")
    #change data types
    facebook_clean_unpaid[cols] <- lapply(facebook_clean_unpaid[cols], as.factor)
    name_temp <- facebook_clean_unpaid
    name_temp_vec <- gsub(" ", "_", colnames(facebook_clean_unpaid))
    colnames(facebook_clean_unpaid) <- name_temp_vec
    
    
    ## -- build figure 3 --
    unpaid_plot <- facebook_clean_unpaid %>% 
    ggplot(aes(x = Lifetime_Post_Total_Reach/100,
               y = Total_Interactions,
               shape = Type,
               color = Type,
               fill = Type)) +
    geom_point(alpha=0.6, size=4) +
    labs(x = "Total reach (hundreds)", y = "Total interactions",
         title = "Figure 3. Total reach vs total interactions", group = "Type")+
    scale_y_continuous(limits = c(0,900)) +
    scale_x_continuous(limits = c(0,500)) +
    scale_shape_manual(values = c(21,22,23,24)) +
    scale_size_manual(values=c(1,6,7,9)) +
    theme_minimal() +
    theme(text = element_text(size = 20))
    options(repr.plot.width =14, repr.plot.height = 8)
    
    #  Save file 3 name and location
    file_name = "03_reachVsInteractions.png"
    ggsave(filename = file_name, plot = unpaid_plot, path = file.path(out_dir), device="png")

  print("image 3 generated")
}

# call main
main(opt[["--input_dir"]], opt[["--out_dir"]])

