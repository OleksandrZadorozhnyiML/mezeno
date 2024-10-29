library(litr)
library(zen4R)


my_token = "9hxUBkJtjtTeWAN1hIFMPrFHOG53vku0QdMeqrNXO113U7achzZ6drn4l4CB"

zenodo = ZenodoManager$new(
  logger = "INFO", # use "DEBUG" to see detailed API operation logs, use NULL if you don't want logs at all
  token = my_token
  )

# provides an interface to the zenodo packages https://cran.r-project.org/web/packages/zen4R/vignettes/zen4R.html

com1 = zenodo$getCommunities()

# we can retrieve useful information from the description in the metadata of the file with the given doi
my_zenodo_records = zenodo$getDepositions()

my_rec = zenodo$getDepositionByDOI("10.5281/zenodo.7676616")

my_rec1 = zenodo$getDepositionByDOI("10.5281/zenodo.7681811")

my_rec2 = zenodo$getDepositionByDOI("10.5281/zenodo.8063512")

my_rec_new = zenodo$getFiles("7676616")

my_rec3 = zenodo$getDepositionById("8063512")

my_rec4 = zenodo$getDepositionByConceptDOI("zenodo.7676616")


rec <- zenodo$getRecordByDOI("10.5281/zenodo.7886284")


rec1 <- zenodo$getRecordByDOI("10.5281/zenodo.8058964")
files <- rec1$listFiles(pretty = TRUE)

#create a folder where to download my files
dir.create("download_zenodo")

#download files
rec1$downloadFiles(path = "download_zenodo")
downloaded_files <- list.files("download_zenodo")



zipF = sprintf("download_zenodo/%s",downloaded_files)
outDir = sprintf("download_zenodo\\%s",downloaded_files)

unzip(zipF,exdir = "./")

alarm_name = list.files(tools::file_path_sans_ext(downloaded_files))[1]

path_to_file = paste0(tools::file_path_sans_ext(downloaded_files),"/",alarm_name,"/",alarm_name,".csv")

df = read.csv(path_to_file)


####### here are the main data qualities from a package from zenodo file +++++++++++


# LIBRARIES to use the LLM

devtools::install_github("AlbertRapp/tidychatmodels")

library(tidyverse)
library(tidychatmodels)

# usage of the r package to iniate the usage of LLM




zenodo <- ZenodoManager$new(
  logger = "INFO" # use "DEBUG" to see detailed API operation logs, use NULL if you don't want logs at all
)

rec_new = zenodo$getRecordByDOI("https://doi.org/10.5281/zenodo.8058964")






rec_new$downloadFiles(path = "download_zen/",files = "airquality_description.Rmd")

zen_files <- zenodo$getFiles(rec_new$id)

#### exporting the metadata in the following format #####################

rec_new$exportAsAllFormats(filename = "myfilename")

rec_new$exportAsJSON(filename = "myfilename.Rmd")


rec_new
# here the basic of the meta-data extraction from the zenodo.org repository

rec_new_inst = ZenodoRequest$new()



###### testing new records on zenodo


# adding files to the new repo



##### community analysis using the correspondent catching files ###########

library(litr)
library(zen4R)

my_token = "9hxUBkJtjtTeWAN1hIFMPrFHOG53vku0QdMeqrNXO113U7achzZ6drn4l4CB"

zenodo = ZenodoManager$new(
  logger = "INFO", # use "DEBUG" to see detailed API operation logs, use NULL if you don't want logs at all
  token = my_token
)


library(jsonlite)
library(rjson)

community_gm = zenodo$getCommunityById("mardigmci")
community_records = community_gm$links$records

# mydata = fromJSON(community_records)

# importing the json file with the information on the records and transposing it to the data file

library(RCurl)
rawData = getURL(community_records)
data = fromJSON(community_records)


library(httr)
library(XML)
library(dplyr)

library(rvest)

library("stringr")                # Load stringr package

find_grnd_trth = function(text){
  subs_to_find = "ground truth"
  position = str_locate(text, subs_to_find)
  substring_after_position = substr(text,position[2]+1, nchar(text))
  # Substring to search for
  substring_to_find = "yes"

  # Use regexpr to find the starting position of the first occurrence
  match = regexpr(substring_to_find, substring_after_position)

  # Check if a match is found
  if (match >= 0) {
    # Calculate the actual position in the original string
    actual_position = position[2] + match - 1
    return(1)
    # Print the result
    print(actual_position)
  } else {
    return(0)
  }

}

find_numb_feat = function(text){

  subs_to_find = "of features"

  position = str_locate(text, subs_to_find)

  # Original string
  #original_string = "This is an example string with the first integer 123 and another integer 456."
  original_string = text

  # Position after which to search for the first integer
  search_position = position[2]+1
  # Extract substring after the specified position
  substring_after_position = substr(original_string, search_position, nchar(original_string))

  # Use regular expression to find the first integer
  match = regexpr("\\b\\d+\\b", substring_after_position, perl = TRUE)

  # Extract the first integer using regmatches
  first_integer = regmatches(substring_after_position, list(match))

  # Convert the result to numeric
  first_integer = as.numeric(first_integer[[1]])
  return(first_integer)

}

find_graph_type = function(text){

}







total_number_of_records = data$hits$total

one_sample_record = data$hits$hits[[2]]
one_sample_record_id = one_sample_record$id

c = data$hits$hits


# description of the record, more precisely the title
one_sample_record$metadata$title

# the dataframe where the information will be stored

df = data.frame(
  Name = character(),  # Character data for description of the dataset, change accordingly
  Number_of_features = numeric(),    # Number of features of the considered dataset, change accordingly
  Ground_Truth = numeric(),    # Availability of the ground truth of the considered dataset, change accordingly
  DOI = character() #Doi of the considered dataset, change accordingly

)
colnames(df) = c("Name","Number of features","Avalaibility of ground truth")


for (item in 1:total_number_of_records){
  curr_info = data$hits$hits[[item]]
  desc_info = rec_new$metadata$description
  ### looking for a position of the number of features in the string ###

  u = read_html(desc_info)
  extracted_text = html_text(u)
  mod_text = gsub("\n"," ",extracted_text)
  mod_text = tolower(mod_text)

  numb_of_features = find_numb_feat(mod_text)

  ### adding new metadata to the dataframe ###

  # Add one observation to the dataframe
  new_observation <- data.frame(
    Name = curr_info$metadata$title,
    Number_of_features = numb_of_features,
    Ground_Truth = find_grnd_trth(mod_text),
    DOI = curr_info$metadata$doi
  )

  # Adding the new observation to the data frame using rbind
  df <- rbind(df, new_observation)

  print(curr_info$metadata$title)
  print(sprintf("Number of features in the dataset is at least: %i", numb_of_features))
  ###  to investigate the availability of ground truth file
  print(sprintf("Ground truth: %i", find_grnd_trth(mod_text)))

}

library(httr)
library(XML)
library(dplyr)


library(rvest)

# reading the documents from a library and modifying the text to exclude the symbols
one_sample_record = data$hits$hits[[2]]
u = read_html(one_sample_record$metadata$description)
extracted_text = html_text(u)
mod_text = gsub("\n"," ",extracted_text)
mod_text = tolower(mod_text)

print(mod_text)

### searching for a certain substring in a string of the information ###
library(stringr)

subs_to_find = "of features"

position = str_locate(mod_text, subs_to_find)

# Original string
#original_string = "This is an example string with the first integer 123 and another integer 456."
original_string = mod_text

# Position after which to search for the first integer
#search_position = 2
search_position = position[2]+1
# Extract substring after the specified position
substring_after_position = substr(original_string, search_position, nchar(original_string))

# Use regular expression to find the first integer
match = regexpr("\\b\\d+\\b", substring_after_position, perl = TRUE)

# Extract the first integer using regmatches
first_integer = regmatches(substring_after_position, list(match))

# Convert the result to numeric
first_integer = as.numeric(first_integer[[1]])

# Print the result
print(first_integer)

### finding the availability of the ground truth in a graph

print(mod_text)
subs_to_find = "ground truth"
position = str_locate(mod_text, subs_to_find)

substring_after_position = substr(mod_text,position[2]+1 , nchar(mod_text))
# Substring to search for
substring_to_find = "no"

# Use regexpr to find the starting position of the first occurrence
match = regexpr(substring_to_find, substring_after_position)

# Check if a match is found
if (match >= 0) {
  # Calculate the actual position in the original string
  actual_position = position[2] + match - 1
  flag = 1
  print(flag)
  # Print the result
  print(actual_position)
} else {
  flag = 0
  print(flag)
}


my_dataframe = data.frame(
  Name = string(),  # Assuming you want character data, change accordingly
  Number_of_features = numeric(),    # Assuming you want numeric data, change accordingly
  Ground_Truth = logical()     # Assuming you want logical data, change accordingly
)
colnames(my_dataframe) = c("Name","Number of features","Avalaibility of ground truth")

# Add one observation to the dataframe
new_observation <- data.frame(
  Name = "Test",
  Number_of_features = 4,
  Ground_Truth = TRUE
)

# Adding the new observation to the data frame using rbind
df <- rbind(my_dataframe, new_observation)

##### Looking for a dataset with a given range of number of features and taking it from zenodo


# example looking for a datasets with certain range of number of features

numb_feat_max = 20
numb_feat_min = 10

df_sub = df[df$Number_of_features >=numb_feat_min & df$Number_of_features<=numb_feat_max,]


#df$Number_of_features >=10 & df$Number_of_features<=20




rec_new = zenodo$getRecordByDOI("https://doi.org/10.5281/zenodo.8063512")


rec_new$files

#### create a large description file where


rec_new$metadata



