#' get_candidates_from_network Function
#'
# queries humap database for edges containing the genes of interest
# return dataframe of edges
#' @param network_measure either 'strength' or 'eigen_centrality'
#' @param blacklist vector of genes to be removed from candidate list, presumably because once they were degs
#' @param g a igraph
#' @export

get_candidates_from_network <- function(g , network_measure,  blacklist){
  require(igraph)
  require(tibble)
  require(dplyr)
  if (network_measure == 'strength'){
    gene_candidates <- as.data.frame(igraph::strength(g))
  }
  if (network_measure == 'eigen_centrality'){
    gene_candidates <- as.data.frame(eigen_centrality(g))
  }
  gene_candidates <- rownames_to_column(gene_candidates, var = 'gene')
  gene_candidates <- gene_candidates %>%
    filter(!(gene %in% blacklist))

  return(gene_candidates)



}
