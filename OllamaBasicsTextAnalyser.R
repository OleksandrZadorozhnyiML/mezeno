
install.packages("openai")
devtools::install_github("isinaltinkaya/gptchatteR")


library(gptchatteR)

chatter.auth(Sys.getenv('OPENAI_API_KEY'))
chatter.create(model = "gpt-3.5-turbo",
               temperature = 0,
               max_tokens = 100,)

sample_Text = "Two preprocessed datasets collected from the UCI repository that can be used for the purpose of structure learning from multivariate data of different types. The Airquality dataset contains 9358 instances of hourly averaged responses from an array of 5 metal oxide chemical sensors embedded in an Air Quality Chemical Multisensor Device. The device was located on the field in a significantly polluted area, at road level, within an Italian city. Data were recorded from March 2004 to February 2005 (one year), representing the longest freely available recordings of on-field deployed air quality chemical sensor device responses [1].
The USCensus1990 data set is a discretized version of the USCensus1990raw data set. The data was collected as part of the 1990 census, and it describes one percent sample of the Public Use Microdata Samples (PUMS) person records drawn from the full 1990 census sample (all fifty states and the District of Columbia but not including  \"PUMA Cross State Lines One Percent Persons Records [2] Size of dataset: 9358, 2458285 correspondingly
Number of features: 16, 68 correspondingly Ground truth: No."

message_features = paste("Q: What is the number of features? Return list of values")
message_ground_truth = paste("Q: What is the ground truth of the graph? Return yes/no.")
message_number_of_obs = paste("Q: What is the size of the dataset in the description? Return list of values.")
message_type_of_graph = paste("Q: What is the type of graph of the dataset? If none return \"unknown. ")
message_researchers = paste("Q: What are the authors in the references of the dataset. Return list of values.")
message_descr = paste("Q: Provide short, one sentence description of the dataset.")

message_new = paste('Analyze description of the dataset. Answer the questions marked as Q:. As an output provide a json file in the following format:
                    [ { "Numb of features": value, "Ground truth": value, "Size": value, "Type of graph": value, "Related researchers": value-list "Description": value}')

message_total = paste(message_new,message_features,message_ground_truth,message_number_of_obs,message_type_of_graph, message_researchers,"Description of the dataset:",mod_text)


#remotes:: install_github("mlverse/chattr")
#library(tidyverse)
#library(chattr)
#resp = chattr("How much is 2 plus 3?")
#resp


#install.packages("rollama")


library(rollama)

library(tibble)


q_set <- tribble(
  ~role, ~content,
  "system", "Search in the text after the words <<desciption of the dataset>>. If possible answer with only a number, yes/no or list of answers. If possible return list of outcomes",
  "user",   message_total
)


q_set1 <- tribble(
  ~role, ~content,
  "system", "analyze the json",
  "user",   rawData
)



string_of_integers = ans$message$content

# Split the string into a vector of character strings
vector_of_strings = strsplit(string_of_integers, ",")[[1]]

# Convert the vector of character strings to a vector of integers
list_of_integers = as.numeric(vector_of_strings)
list_of_integers



install.packages("ollamar")
library(ollamar)


test_connection()  # test connection to Ollama server




# Extract subjects as a vector
subjects_vector <- sapply(rec_new$metadata$subjects, function(x) x$subject)

# Print the result
print(subjects_vector)
