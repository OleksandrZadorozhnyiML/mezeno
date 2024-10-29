# Generated from create_mezen.Rmd: do not edit by hand

#' create dataframe with the information
#' 
#' 
#' 
#' @export 
create_dataframe <- function(){
  df = data.frame(
  ZenodoID = character(),  # Character data for description of the dataset, change accordingly
  CollectionName = character(),
  DOI = character(),
  Number_of_features = I(list()),    # Number of features of the considered dataset, change accordingly
  Number_of_observations = I(list()),
  Ground_Truth = numeric(),    # Availability of the ground truth of the considered dataset, change accordingly
  Type_of_Graph = character(),
  Description = character(),
  Authors = I(list()),
  Researchers = I(list())
  )
  colnames(df) = c("Number/ZenodoId","Name of the collection","DOI","Number of features","Number of observations","Ground Truth","Type of Graph","Description","Authors","Related researchers")
  return(df) 
}
