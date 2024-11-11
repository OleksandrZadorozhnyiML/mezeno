# Generated from create_mezen.Rmd: do not edit by hand

#' Question to the LLM
#' 
#' @param question_text parameter that sets the input text 
#' 
#' @export 
#' 
download_data <- function(question_text,json_file="example.json"){
  text_pre = paste("Retrieve the json item for the dataset",question_text,"Json File:")
  
  json_data = fromJSON(json_file)
  # Convert JSON data to a text format (pretty-printed)
  text_data = toJSON(json_data, pretty = TRUE, auto_unbox = TRUE)
  line = paste(text_pre,text_data)
  
  
  
  q_set = tribble(
                            ~role, ~content,
                            "system", 'Retrieve the json item for the dataset. As output use only json-item from the json file and nothing else.',
                            "user",   line
                   )
  
  ans_net = query(q_set,model_params = list(seed = 42, temperature = 0),model = "llama3.1" )
  
  retrieved_text = ans_net$message$content
  
  q_set = tribble(
                            ~role, ~content,
                            "system", 'Retrieve the zenododoi item for the dataset. As output return only number after zenodo. and nothing else.',
                            "user",   retrieved_text
                   )
  ans_llm  = query(q_set,model_params = list(seed = 42, temperature = 0),model = "llama3.1")
  
  
  
  # finding the zenodo doi which is then be transformed to an integer to download a record from
  link = paste0("https://doi.org/10.5281/zenodo.",find_integer_in_text(ans_llm$message$content))
  # downloading the record contained in the link
  
  dir.create("./download_zenodo")
  #download files with shortcut function 'download_zenodo'
  download_zenodo(path = "download_zenodo", link,timeout = 180)
  downloaded_files <- list.files("download_zenodo")
  
}
