#' get_encode_edges Function
#'
#'STILL NOT WORKING!
# queries encode 2015 database for edges containing the genes of interest
# return dataframe of edges
#' @param vector_of_gene_symbols A character vector of gene symbols
#' @param type_of_regulation Either 'direct' or 'common_tf'
#' @export
get_encode_edges <- function(vector_of_gene_symbols, type_of_regulation) {
  require(lubtools)
  require(dplyr)
  data(encode)
  if (type_of_regulation == 'common_tf'){
    edgelist <- data.frame(edge_1 = c('mock'), edge_2 = c('mock'))
    edgelist <- edgelist[-1, ]


  }


  upstream_tfs <- list()

  for (gene in vector_of_gene_symbols) {
    upstream_tfs[[gene]] <- list()
    print(gene)
    flag = 0
    n_of_genes_found = 0
    for (each_set in encode$genesets){
      flag <- flag + 1
      if (gene %in% each_set){
      n_of_genes_found <- n_of_genes_found +1
      print('it is!')
      print(encode$geneset.names[flag])
      tf <- encode$geneset.names[flag]
      upstream_tfs[gene][[n_of_genes_found]] <- tf

      }

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
