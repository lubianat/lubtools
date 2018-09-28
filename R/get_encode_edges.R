#' get_encode_edges Function
#'
# queries encode 2015 database for edges containing the genes of interest
# return dataframe of edges
#' @param vector_of_gene_symbols A character vector of gene symbols
#' @param type_of_regulation Either 'direct' or 'common_tf'
#' @param verbose If true, adds verbosity. Defaults to true.
#' @export
#'
get_encode_edges <-
  function(vector_of_gene_symbols,
           type_of_regulation, verbose =T) {
   # print('ok')
    data(encode)
    if (type_of_regulation == 'common_tf') {
      edgelist <- data.frame(edge_1 = c('mock'), edge_2 = c('mock'))
      edgelist <- edgelist[-1,]
      upstream_tfs <- list()
      vector_of_gene_symbols <- joint_genes
      for (gene in vector_of_gene_symbols) {

        flag = 0
        print(paste(gene,flag))
        n_of_genes_found = 0
        for (each_set in encode$genesets) {
          flag <- flag + 1
          if (gene %in% each_set) {
            n_of_genes_found <- n_of_genes_found + 1
            #      print(encode$geneset.names[flag])
            tf <- encode$geneset.names[flag]
            hm <- c(upstream_tfs[[gene]], tf)
            upstream_tfs[[gene]] <- hm
          }

        }


      }

      if(length(upstream_tfs) == 0 | length(upstream_tfs)  == 1){ return(edgelist)  }

      for (upstream_tf_now in 1:(length(upstream_tfs) - 1)) {
          if (verbose == T){
          print(paste('looking for gene', upstream_tf_now, 'out of', length(upstream_tfs)))
}

        for (upstream_tf_to_compare in (upstream_tf_now + 1):length(upstream_tfs)) {
          if (sum(upstream_tfs[[upstream_tf_now]] %in% upstream_tfs[[upstream_tf_to_compare]]) >= 3) {


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
