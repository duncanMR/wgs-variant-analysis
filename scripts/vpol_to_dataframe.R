library("tidyverse")
library("data.table")

extract_anno = function(string) {
  mat <- t(str_match_all(string,"([^;=]+)=([^;=]+)")[[1]][,2:3]) #fetch INFO field data as d.t
  mat[mat=="."] <- NA
  tbl <- as.data.table(mat)
  setnames(tbl, as.character(tbl[1]))[2,] #use the first row as col names for the second row
}

expand_info_column = function(vpot_file) {
  vpot_data <- fread(vpot_file)
  dt_list <- sapply(vpot_data$INFO, extract_anno)
  info <- as.data.table(type_convert(rbindlist(dt_list, use.names=TRUE, fill=TRUE)))
  cbind(vpot_data[,INFO:=NULL], info)
}

#dt_list <- sapply(vpot_data$INFO, extract_anno)
#dat <- expand_info_column("vpot_filtered.tsv")
