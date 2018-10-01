#' get_humap_edges Function
#'
# queries humap database for edges containing the genes of interest
# return dataframe of edges
#' @param vector_of_gene_symbols A character vector of gene symbols
#' @export

get_humap_edges <- function(vector_of_gene_symbols) {
  require(lubtools)
  require(dplyr)

  data(humap)

  node_one <- as.vector(humap$V1)
  node_two <- as.vector(humap$V6)
  humap %>%
    filter(node_one %in% vector_of_gene_symbols & node_two %in% vector_of_gene_symbols)
}
