#' list_disgenet_info Function
#' list diseases for a given query
#' @param disease string containing the disease you are looking for (use first letter uppercase )
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
list_disgenet_info <- function(disease, database_path){
  require(DBI)
  require(RSQLite)
  require(dplyr)
  db = dbConnect(SQLite(), dbname=database_path)
  query = paste0("SELECT * FROM diseaseAttributes WHERE diseaseName LIKE '%",disease,"%'")
  possibleIds <- dbGetQuery(db, query)
  print(possibleIds)


}
