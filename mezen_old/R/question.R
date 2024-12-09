# Generated from create_mezen.Rmd: do not edit by hand

#' Asks LLM to retrieve the information
#' 
#' @param question_text parameter that define the questions that is targeted towards the LLM 
#' 
#' @export 
#' 
question <- function(question_text,json_file="example.json"){
  text_pre = "Answer the question based only on the input of the following json file.  As output use only text from the json file and nothing else. If thereis nothing to output, return <>. Json File:"
  json_data <- fromJSON(json_file)
  # Convert JSON data to a text format (pretty-printed)
  text_data <- toJSON(json_data, pretty = TRUE, auto_unbox = TRUE)
  line = paste(text_pre,text_data,"Question:",question_text)
  
  
  
  q_set <- tribble(
                            ~role, ~content,
                            "system", 'Answer the question based only on the input of the json file. As output use only text from the json file. As output use only text from the json file and nothing else. If thereis nothing to output, return <>',
                            "user",   line
                   )
  
  query(q_set,model_params = list(seed = 42, temperature = 0),model = "llama3.1" )
}
