library("readr")
library("stringr")
library("data.table")

extract_anno = function(string) {
  mat <- t(str_match_all(string,"([^;=]+)=([^;=]+)")[[1]][,2:3]) #fetch INFO field data as d.t
  mat[mat=="."] <- NA
  tbl <- as.data.table(mat)
  setnames(tbl, as.character(tbl[1]))[2,] #use the first row as col names for the second row
}

#list of variables which should be characters and not factors
character_vars<-list("GeneDetail.refGene","AAChange.refGene", "Aloft_pred", "Aloft_Confidence",
                     "Interpro_domain","GTEx_V8_gene", "GTEx_V8_tissue","CLNDISDB")

expand_info_column = function(vpot_data) {
  DT_list <- sapply(vpot_data$INFO, extract_anno)
  DT_raw <- as.data.table(type_convert(rbindlist(DT_list, use.names=TRUE, fill=TRUE)))
  DT <- cbind(vpot_data[,INFO:=NULL], DT_raw)
  for (j in seq_len(ncol(DT))) {
    if(class(DT[[j]]) == 'character' && !(names(DT)[j] %in% character_vars))
      set(DT, j = j, value = as.factor(DT[[j]]))
  }
  #setkey(DT,Ranking)
  setnames(DT, "#CHROM", "CHROM")
  DT
}
#vpot_data <- fread("vpot_filtered.txt")
#dt_list <- sapply(vpot_data$INFO, extract_anno)
#DT <- expand_info_column(vpol_data)


