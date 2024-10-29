# Generated from create_mezen.Rmd: do not edit by hand

#' 
#'
#' @param description_text where the LLM has to find the findings 
#' @export
read_and_search <- function(description_text){
  
  message_features = paste("What is the number of features? Return list of values")
  message_ground_truth = paste(" What is the ground truth of the graph? Return yes/no.")
  message_number_of_obs = paste(" What is the size of the dataset in the description? Return list of values.")
  message_type_of_graph = paste("What is the type of graph of the dataset? If none return \"unknown. ")
  message_researchers = paste("What are the authors in the references of the dataset. Return list of values.                               ")
  message_summary = paster("Could you provide a summary of the description of the dataset. Return one sentence.")
  
  message_total = paste(message_features,message_ground_truth,message_number_of_obs,message_type_of_graph, message_researchers, message_summary, "Description of the dataset:",description_text)
  
  
q_set <- tribble(
  ~role, ~content,
  "system", "Reply to the questions. Search in the text after the words <<desciption of the dataset>>. If possible answer with only a number, yes/no or list of answers. If possible return list of outcomes.",
  "user",   message_total
)


}
