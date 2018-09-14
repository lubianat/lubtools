#' get_KEA_edges Function
#'
# queries KEA 2018 database for edges containing the genes of interest
# return dataframe of edges
#' @param vector_of_gene_symbols A character vector of gene symbols
#' @export

get_KEA_edges <- function(vector_of_gene_symbols) {
  require(lubtools)
  require(dplyr)
  data(KEA)
  edgelist <- data.frame(edge_1 = c('mock'), edge_2 = c('mock'))
  edgelist <- edgelist[-1, ]
  upstream_kinases <- list()
  for (gene in vector_of_gene_symbols) {
    if (gene %in% KEA$V4) {
      upstream_kinases[[gene]] <- KEA$V3[KEA$V4 == gene]
    }

  }

  for (kinase_target_now in 1:(length(upstream_kinases)-1)) {
    print(kinase_target_now)
    for (kinase_target_to_compare in (kinase_target_now+1):length(upstream_kinases)) {
      print(kinase_target_to_compare)
      if (any(upstream_kinases[[kinase_target_now]] %in% upstream_kinases[[kinase_target_to_compare]])) {
        new_edge <- data.frame(names(upstream_kinases[kinase_target_now]), names(upstream_kinases[kinase_target_to_compare]))
        edgelist <-  rbind(edgelist,new_edge )
      }
    }
  }
  colnames(edgelist) <- c('node_1', 'node_2')
 return(edgelist)

}
