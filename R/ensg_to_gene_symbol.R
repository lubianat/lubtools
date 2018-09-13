# this script runs biomart to chanse ENSG to gene symbols
# WRITTEN BY TIAGO lUBIANA 18/08/2018


#' ensg_to_gene_symbol Function
#'
#' This function allows you to Gets biomart table (august/2018)
#'  to change ensgs to gene symbols
#' @param ensg_character_vector A character vector of ensemble gene ids (such as 'ENSG00000134057')
#' @export


ensg_to_gene_symbol <- function(ensg_character_vector){
  data('biomart_august_2018')
  genes[genes$ensembl_gene_id %in% ensg_character_vector,]$hgnc_symbol
}

# this script runs biomart to chanse ENSG to gene symbols
# WRITTEN BY TIAGO lUBIANA 18/08/2018


#' ensg_to_ensp Function
#'
#' This function allows you to Gets biomart table (august/2018)
#'  to change ensgs to ensp
#' @param ensg_character_vector A character vector of ensemble gene ids (such as 'ENSG00000134057')
#' @export


ensg_to_ensp <- function(ensg_character_vector){
  data('biomart_august_2018')
  genes[ensg_table$ensembl_gene_id %in% ensg_character_vector,]$ensemble_peptide_id
}
