#' get_candidates_from_network Function
#'
# queries humap database for edges containing the genes of interest
# return dataframe of edges
#' @param network_measure either 'strength' or 'eigen_centrality'
#' @param top_candidates the portion of candidates that will be taken
#' @export

get_candidates_from_network <- function(g , network_measure, top_candidates, blacklist){
  require(igraph)
  if (network_measure == 'strength'){
    gene_candidates <- as.data.frame(strength(g))
  }
  if (network_measure == 'eigen_centrality'){
    gene_candidates <- as.data.frame(eigen_centrality(g))
  }
  gene_candidates <- gene_candidates %>%
    filter(!(gene %in% blacklist))

  gene_candidates_top <- gene_candidates %>%
    arrange(desc(`strength(g)`)) %>%
    head(top_candidates*length(gene_candidates))
  return(gene_candidates_top)



}
