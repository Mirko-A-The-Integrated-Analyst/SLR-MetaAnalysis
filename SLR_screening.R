####################################################################################
##################                                                ##################
##################                  SLR_Screening                 ##################
##################                                                ##################
####################################################################################
# Project Showcase Notice ----
#This repository contains code and materials for the purpose of showcasing the project. Please note that sensitive and official parts of the project have been either partially or totally removed.
#Purpose
#The content provided here is intended to demonstrate the capabilities, design patterns, and methodologies employed in the project. It is not meant for production use and may lack certain functionalities that are part of the full, official version.
#Limitations
#- **Sensitive Information**: Any sensitive information, including but not limited to private keys, credentials, and personal data, has been removed or anonymized.
#- **Partial Functionality**: Some sections of the code may have been modified or omitted to ensure the security and privacy of the underlying system or data. As such, the repository may not represent the full functionality of the original project.
#- **Showcase Only**: The provided code and documents are intended for viewing and demonstration purposes only.


library (revtools)

data_list <- read_bibliography("SInternalUseOnly.ris")
data_list3 <- read_bibliography( "InternalUseOnly.csv")
data_list2 <- read_bibliography(c("InternalUseOnly.nbib", "InternalUseOnly.ris", "InternalUseOnly.csv"), return_df = TRUE)
str(as.data.frame(data_list2))
summary(data_list2)
write.csv(data_list2, "data_list2.csv")
write_bibliography(data_list3, "data_list3.ris", format = "ris")

data_list2Exported_Items <- read_bibliography("Exported_Items.ris")
data_list2_Items1 <- read_bibliography("1.ris")
library(kulife)
library(XML)
write.xml(data_list2,"data_list2.xml")

# find duplicated DOIs within the dataset
doi_match <- find_duplicates(data_list2,
                             match_variable = "doi",
                             group_variables = NULL,
                             match_function = "exact"
)

doi_match2 <- find_duplicates(data_list2,
                             match_variable = "abstract",
                             group_variables = NULL,
                             match_function = "exact"
)

doi_match3 <- find_duplicates(data_list2,
                              match_variable = "title",
                              group_variables = NULL,
                              match_function = "exact"
)

# automatically extract one row per duplicate
data_unique <- extract_unique_references(data_list2,
                                         doi_match)
nrow (data_unique)


data_unique2 <- extract_unique_references(data_list2,
                                         doi_match)
nrow (data_unique2)


# an alternative is to try fuzzy title matching
title_match <- find_duplicates(data_list2,
                               match_variable = "title",
                               group_variables = NULL,
                               match_function = "stringdist",
                               method = "osa",
                               threshold = 5
)
length (unique (title_match))
title_match.df <- as.data.frame(title_match)
str(title_match.df)

screen_duplicates(data_list2)
# useful for screnning title
screen_titles(data_list2)
screen_abstracts(data_list2_Items1)

run_topic_model(data_list2, type = "lda", n_topics = 10, iterations = 2000)
x_dtm <- make_dtm(data_list2$title, stop_words = revwords("nudg"))
x_dtm

# Screen topics
result <- screen_topics(data_list2)
screen_topics(data_unique)
articles_data <- result$raw
env_articles <- articles_data[which (articles_data
                                     $selected),]
nrow (env_articles) # n = 186



# Review article  
library(metagear)
getw

data_scopus <- read_bibliography("InternalUseOnly.csv")
data_list3 <- read_bibliography(c("InternalUseOnly.nbib", "InternalUseOnly.ris", "InternalUseOnlycsv"), return_df = TRUE)
## Assign the work
theTeam <- c("InternalUseOnly", "Others")

assigned.dat= effort_distribute(aDataFrame = data_list3, dual = FALSE, 
                                reviewers = theTeam, 
                                column_name = "REVIEWERS", 
                                effort = NULL, initialize = TRUE, 
                                save_split = TRUE, directory = getwd())

abstract_screener(file="InternalUseOnly.csv", 
                  aReviewer = "InternalUseOnly", reviewerColumnName="REVIEWERS", 
                  abstractColumnName = "abstract", unscreenedColumnName = "INCLUDE", 
                  unscreenedValue="not vetted", titleColumnName = "title")
