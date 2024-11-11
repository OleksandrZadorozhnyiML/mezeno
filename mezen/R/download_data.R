# Generated from create_mezen.Rmd: do not edit by hand

#' Question to the LLM
#' 
#' @param question_text parameter that sets the input text 
#' 
#' @export 
#' 
download_data <- function(question_text,json_file="example.json"){
  text_pre = paste("Give the zenododoi of the dataset:",question_text,"As output use only the numbers from the following json file and nothing else. If thereis nothing to output, return <>. Json File:")
  
  json_data = fromJSON(json_file)
  # Convert JSON data to a text format (pretty-printed)
  text_data = toJSON(json_data, pretty = TRUE, auto_unbox = TRUE)
  line = paste(text_pre,text_data)
  
  
  
  q_set = tribble(
                            ~role, ~content,
                            "system", 'Give the zenodoid based only on the input of the json file. As output use only the text from the json file. As output use only text from the json file and nothing else. If thereis nothing to output, return <>',
                            "user",   line
                   )
  
  query(q_set,model_params = list(seed = 42, temperature = 0),model = "llama3.1" )
}
