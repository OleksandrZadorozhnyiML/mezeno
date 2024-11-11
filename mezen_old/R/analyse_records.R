# Generated from create_mezen.Rmd: do not edit by hand

#' analyses the records within the given list of community records and extracts the metainformation from it
#' 
#' @param gmci_records_id Name of a person
#' 
#' @export 
#' 
analyse_records <- function(gmci_records_id){
  # A function which analyses the community records and fills in the information about the dataset. Manual part. 
    library(dplyr)
    my_token = "9hxUBkJtjtTeWAN1hIFMPrFHOG53vku0QdMeqrNXO113U7achzZ6drn4l4CB"
    key_token = my_token
    zenodo = ZenodoManager$new(logger = "INFO",token = key_token)
  
    numb_of_records = length(gmci_records_id)
    # create two dataframes to 
    json_data = list()
    json_description_data = list()
    
    # setting up the chatter 
    message_features = paste("Q: What is the number of features? Return list of   values")
    message_ground_truth = paste("Q: What is the ground truth of the graph? Return yes/no.")
    message_number_of_obs = paste("Q: What is the size of the dataset in the description? Return list of values.")
    message_type_of_graph = paste("Q: What is the type of graph of the dataset? If none return \"unknown. ")
    message_researchers = paste("Q: What are the authors in the references of the dataset. Return list of values.")
    message_description = paste("Q: Provide one sentence summary of the description of the dataset.")
    message_new = paste('Analyze description of the dataset. Answer the questions marked as Q:. As an output provide one json file in the following format:
                     [{ "Numb_of_features": value, "Ground_truth": value, "Size": value, "Type_of_graph": value, "Author_references": value/list of values, "One_sentence_description": value}]')


    
    for (item in 1:numb_of_records){
      # consider one record from the community   
        rec_curr = zenodo$getRecordByDOI(gmci_records_id[item])
         
         # extract list of subjects 
         subjects_vector = list(sapply(rec_curr$metadata$subjects, function(x) x$subject))
         # extract the list of creators of the dataset
         creator_names_vector = list(sapply(rec_curr$metadata$creators, function(x) x$person_or_org$name))
         # extract the id of the record of the dataset on zenodo
         zenodo_id = rec_curr$id
         # extract the doi of the records of the dataset on zenodo
         zenodo_doi = rec_curr$links$doi
         # extract the title of the record of the dataset on zenodo
         zenodo_title = rec_curr$metadata$title
         # store the license of the record of the dataset on zenodo
         zenodo_license_info = rec_curr$metadata$rights[[1]]$id
         # store the url under which the datasets is reachable
         zenodo_url = rec_curr$links$self
         # extract the information about the views and downloads of the record
         zenodo_uqviews = rec_curr$stats$this_version.unique_views
         zenodo_downlds = rec_curr$stats$this_version.unique_downloads
         license_title = rec_curr$metadata$rights[[1]]$title$en
         url_link = rec_curr$links$self
         
         
         
         # modifying the text for the to make it readable
         desc_info = rec_curr$metadata$description
                ### looking for a position of the number of features in the string ###
         # modifying the text to make it accesible for a LLM query
         u = read_html(desc_info)
         extracted_text = html_text(u)
         mod_text = gsub("\n"," ",extracted_text)
         mod_text = tolower(mod_text)
         
         # gathering the information into the list to put it inside the 
         
         
         
          message_total =   paste(message_new,message_features,message_ground_truth,message_number_of_obs,message_type_of_graph, message_researchers,message_description,"Description of the dataset:",mod_text)
         
          q_set <- tribble(
                            ~role, ~content,
                            "system", 'Answer the questions. If possible answer with only a number, yes/no or list of answers. If possible return list of outcomes for the value. Output NO other text, but one json file in the following format: [{ "Numb_of_features": value, "Ground_truth": value, "Size": value, "Type_of_graph": value, "Author_references": value/list of values, "One_sentence_description": value}]',
  "user",   message_total
)
          answer_curr = query(q_set,model_params = list(seed = 42, temperature = 0),model = "llama3.1")
          
          #new_entry = list(
          #                zenodoid = zenodo_id,
          #                title = zenodo_title,
          #                zenododoi = zenodo_doi,
          #                authors = I(creator_names_vector),
          #                license = license_title,
          #                keywords = I(subjects_vector),
          #                url = url_link,
          #                downloads = zenodo_downlds,
          #                views = zenodo_uqviews
        #)
        #json_data[[item]] = new_entry
         # work with the metadata description file: 
        
        
        
        
        
        # work with the operand returned by the values 
        new_entry_d = fromJSON(answer_curr$message$content)
        
        new_entry_d$title = zenodo_title
        new_entry_d$zenodoid = zenodo_id
        new_entry_d$zenododoi = zenodo_doi
        new_entry_d$authors = creator_names_vector
        new_entry_d$license = license_title
        new_entry_d$keywords = subjects_vector
        new_entry_d$url = url_link
        new_entry_d$downloads = zenodo_downlds
        new_entry_d$views = zenodo_uqviews
         
        # put another order between the variables
        desired_order <- c(
  "title", "zenodoid", "zenododoi", "authors", "license", "keywords", 
  "url", "downloads", "views", 
  "Numb_of_features", "Ground_truth", "Size", 
  "Type_of_graph", "Author_references", "One_sentence_description"
)

        # Reorder the columns in new_entry_d
        new_entry_d <- new_entry_d[desired_order]
        
        
        json_description_data[[item]] = new_entry_d 
         
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
    
    # now 
    
  # Convert lists to data frames
  #df1 = do.call(rbind, lapply(json_data, as.data.frame))
  #df2 = do.call(rbind, lapply(json_description_data, as.data.frame))
  
  # Perform a left join based on the 'name' column
  #merged_df = left_join(df1, df2, by = "title")  
  #merged_list = lapply(1:nrow(merged_df), function(i) merged_df[i, ])
  
  json_data = toJSON(json_description_data, pretty = TRUE)  # 'pretty = TRUE'     makes it more readable
  write(json_data, file = "example.json")
  return(json_description_data)
    
}
