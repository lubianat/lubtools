#' get_candidates_from_network Function
#'
# queries humap database for edges containing the genes of interest
# return dataframe of edges
#' @param network_measure either 'strength' or 'eigen_centrality'
#' @param top_candidates the portion of candidates that will be taken
#' @param blacklist vector of genes to be removed from candidate list, presumably because once they were degs
#' @param g a igraph
#' @export

get_candidates_from_network <- function(g , network_measure, top_candidates, blacklist){
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
 names(gene_candidates)[2] <- 'measure'
  gene_candidates_top <- gene_candidates %>%
    arrange(desc(measure)) %>%
    head(top_candidates*length(gene_candidates))
  return(gene_candidates_top)



}
