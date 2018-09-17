library(DBI)

library(RSQLite)
db = dbConnect(SQLite(), dbname="data/disgenet_2017.db")

alltables = dbListTables(con)
p1 = dbGetQuery( con,'select * from populationtable' )

dbListTables(con)
dbReadTable(db, "diseaseAttributes")

possibleIds <- dbGetQuery(db, "SELECT * FROM diseaseAttributes WHERE diseaseName LIKE '%Dengue%'")

print(possibleIds)

choice <- readline('Which ID do you want? (input the index number)')
library(DBI)

library(RSQLite)
db = dbConnect(SQLite(), dbname="data/disgenet_2017.db")

alltables = dbListTables(con)
p1 = dbGetQuery( con,'select * from populationtable' )

dbListTables(db)
head(dbReadTable(db, "geneDiseaseNetwork"))

possibleIds <- dbGetQuery(db, "SELECT * FROM diseaseAttributes WHERE diseaseName LIKE '%Dengue%'")

print(possibleIds)

if (F){
choice <- readline('Which ID do you want? (input the index number)')
choice <- as.numeric(choice)
} else {
choice <- 1
}

selectedId<- possibleIds$diseaseNID[choice]

possibleEdges <- dbGetQuery(db, paste0('SELECT * FROM geneDiseaseNetwork WHERE diseaseNID IS ', "'", selectedId, "'" ))
geneAttributes <- dbReadTable(db, "geneAttributes")

possibleEdges <- inner_join(possibleEdges,geneAttributes, by="geneNID")

selected_edges <- possibleEdges %>%
  group_by(geneName) %>%
  summarise(n_of_studies = n(), score = max(score))
