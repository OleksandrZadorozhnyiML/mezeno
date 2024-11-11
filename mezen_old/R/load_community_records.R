# Generated from create_mezen.Rmd: do not edit by hand

#' Download the necessary files
#' 
#' @param name parameter that sets the name of the repository 
#' 
#' @export 
#' 
load_community_records <- function(name, exclamation = TRUE) {
  my_token = "9hxUBkJtjtTeWAN1hIFMPrFHOG53vku0QdMeqrNXO113U7achzZ6drn4l4CB"
  key_token = my_token
  zenodo = ZenodoManager$new(logger = "INFO",token = key_token)
  community_gm = zenodo$getCommunityById(name)
  community_records = community_gm$links$records  
  
  data = fromJSON(community_records)
  gmci_records_id = data$hits$hits$doi
  def=list(info = data, records= gmci_records_id)
  return(def)
}
