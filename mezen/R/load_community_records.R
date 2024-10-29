# Generated from create_mezen.Rmd: do not edit by hand

#' Say hello to someone
#' 
#'  
load_community_records <- function(name, exclamation = TRUE) {
  zenodo = ZenodoManager$new(logger = "INFO",token = key_token)
  community_gm = zenodo$getCommunityById("mardigmci")
  community_records = community_gm$links$records  
  data = fromJSON(community_records)
  gmci_records_id = data$hits$hits$doi
  def=list(info = data, records= gmci_records_id)
  return(def)
}
