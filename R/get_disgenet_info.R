#' get_disgenet_info Function
# queries humap database for edges containing the genes of interest
# return dataframe of edges
#' @param disease string containing the disease you are looking for (use first letter uppercase )
#' @param complete_result If true, a comprehensive list explaining
#' the reason behind the associations will be returned.
#' Defaults to false (only score and number of PMIDs for the disease-gene association)
#' @param database_path The addres of the .db file downloaded from
#' http://www.disgenet.org/ds/DisGeNET/files/current/disgenet_2017.db.gz
#' @examples
#' url <- 'http://www.disgenet.org/ds/DisGeNET/files/current/disgenet_2017.db.gz'
#' download.file(url,'./disgenet.R')
#' unzip file manually to data directory
#'
#' disgenet_dengue <- get_disgenet_info('Dengue', database_path = 'data/disgenet_2017.db')
#' @export
#'
get_disgenet_info <- function(disease, complete_result = F, database_path){
  require(DBI)
  require(RSQLite)
  require(dplyr)
  db = dbConnect(SQLite(), dbname=database_path)
  query = paste0("SELECT * FROM diseaseAttributes WHERE diseaseName LIKE '%'",disease,"%'")
  possibleIds <- dbGetQuery(db, "SELECT * FROM diseaseAttributes WHERE diseaseName LIKE '%Dengue%'")
  print(possibleIds)
  choice <- readline('Which ID do you want? (input the index number)')
  choice <- as.numeric(choice)
  selectedId<- possibleIds$diseaseNID[choice]
  possibleEdges <- dbGetQuery(db, paste0('SELECT * FROM geneDiseaseNetwork WHERE diseaseNID IS ', "'", selectedId, "'" ))
  geneAttributes <- dbReadTable(db, "geneAttributes")

  possibleEdges <- inner_join(possibleEdges,geneAttributes, by="geneNID")

  possibleEdges %>%
    group_by(geneName) %>%
    summarise(n_of_studies = n(), score = max(score))


}


