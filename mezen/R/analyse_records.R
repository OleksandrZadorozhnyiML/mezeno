# Generated from create_mezen.Rmd: do not edit by hand

#' analyses the records within the given list of community records 
#' 
#' @param gmci_records_id Name of a person
#' 
#' @export 
#' 
analyse_records <- function(gmci_records_id){
  # A function which analyses the community records
    numb_of_records = length(gmci_records_id)
    for (item in 1:numb_of_records){
         rec_curr = zenodo$getRecordByDOI(gmci_records_id[item])
         # extract list of subjects 
         subjects_vector = sapply(rec_new$metadata$subjects, function(x) x$subject)

         # extract information from the description 
         desc_info = rec_new$metadata$description
                ### looking for a position of the number of features in the string ###
         # modifying the text to make it accesible for a LLM query
         u = read_html(desc_info)
         extracted_text = html_text(u)
         mod_text = gsub("\n"," ",extracted_text)
         mod_text = tolower(mod_text)
         # forming up the query for the LLM ollama. notice: a running version of ollama should be open and              running locally on the device
         
         
         
         
         # Add one observation to the dataframe
   # new_observation <- data.frame(
   #                Name = curr_info$metadata$title,
   #                 Number_of_features = numb_of_features,
   #                  Ground_Truth = find_grnd_trth(mod_text),
   #                 DOI = curr_info$metadata$doi
   #                  Researchers
   # )
  }
}
