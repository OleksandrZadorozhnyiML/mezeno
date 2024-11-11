# Generated from create_mezen.Rmd: do not edit by hand

#' Show the necessary files
#' 
#' @param name parameter that sets the name of the repository 
#' 
#' @export 
#' 
show <- function(name){
  json_data <- fromJSON(name)
  
  # Print the information in a readable format
  print("Information stored in JSON file:")
  print(json_data)
}
