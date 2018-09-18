#' get_encode_edges Function
#'
# queries encode 2015 database for edges containing the genes of interest
# return dataframe of edges
#' @param vector_of_gene_symbols A character vector of gene symbols
#' @param type_of_regulation Either 'direct' or 'common_tf'
#' @export

get_encode_edges <-
  function(vector_of_gene_symbols,
           type_of_regulation) {
    require(dplyr)
    data(encode)
    if (type_of_regulation == 'common_tf') {
      edgelist <- data.frame(edge_1 = c('mock'), edge_2 = c('mock'))
      edgelist <- edgelist[-1,]
      upstream_tfs <- list()

      for (gene in vector_of_gene_symbols) {
        flag = 0
        n_of_genes_found = 0
        for (each_set in encode$genesets) {
          flag <- flag + 1
          if (runif(1) > 0.999) {
            print(each_set)
          }
          if (gene %in% each_set) {
            n_of_genes_found <- n_of_genes_found + 1
            #      print('it is!')
            #      print(encode$geneset.names[flag])
            tf <- encode$geneset.names[flag]
            hm <- c(upstream_tfs[[gene]], tf)
            upstream_tfs[[gene]] <- hm
          }

        }


      }

      # i have no idea why the list generated also included each of the geneset.names.
      # but as I don't want them, I have removed 'em
      upstream_tfs <- upstream_tfs[-c(1:flag)]

      for (upstream_tf_now in 1:(length(upstream_tfs) - 1)) {
        print(upstream_tf_now)
        for (upstream_tf_to_compare in (upstream_tf_now + 1):length(upstream_tfs)) {
          print('vai')
          print('vendo')
          print(upstream_tf_now)
          print('em')
          print(upstream_tf_to_compare)
          if (sum(upstream_tfs[[upstream_tf_now]] %in% upstream_tfs[[upstream_tf_to_compare]]) >= 3) {
            print('hit!')
            new_edge <-
              data.frame(names(upstream_tfs[upstream_tf_now]), names(upstream_tfs[upstream_tf_to_compare]))
            edgelist <-  rbind(edgelist, new_edge)
          }
        }
      }
      colnames(edgelist) <- c('node_1', 'node_2')
      return(edgelist)
    }

    if (type_of_regulation == 'direct') {
      edgelist <- data.frame(edge_1 = c('mock'), edge_2 = c('mock'))
      edgelist <- edgelist[-1,]
      tfs <-
        encode$geneset.names[encode$geneset.names %in% vector_of_gene_symbols]
      target_sets <-
        encode$genesets[encode$geneset.names %in% vector_of_gene_symbols]
      if (length(target_sets) == 0){ return(edgelist)}
      for (gene_tf_index in 1:length(tfs)) {
        for (gene_target in vector_of_gene_symbols) {
          if (gene_target %in% target_sets[[gene_tf_index]] & gene_target != ""){
            new_edge <- data.frame(tfs[gene_tf_index], gene_target)
            edgelist <-  rbind(edgelist, new_edge)
          }

        }
      }

    }
    colnames(edgelist) <- c('node_1', 'node_2')
    return(edgelist)
  }
