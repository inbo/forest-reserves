library(flandersqmd)
library(knitr)
library(quarto)
library(purrr)
library(dplyr)
library(stringr)

plotinfo <- read.csv2('../../data/plotinfo.csv', header = TRUE, dec = ',', sep = ';')
metadata <- read.csv2('../../data/metadata.csv', header = TRUE, dec = ',', sep = ';')

# Kerselaerspleyn samenvoegen bij Zoniën en volgorde aanpassen zoals in metadata
plotinfo$forest_reserve <- ifelse(plotinfo$forest_reserve == "Kersselaerspleyn", "Zwaenepoel", plotinfo$forest_reserve)
plotinfo2 <- left_join(plotinfo, metadata, by = "forest_reserve")
plotinfo2 <- arrange(plotinfo2, Nr)

reserves <- unique(plotinfo2$forest_reserve)
reserves_label <- gsub("\\s", "_", tolower(reserves))
reserves_correct <- metadata[metadata$forest_reserve %in% reserves,]$Correct_name

reserves_kort <- metadata$forest_reserve[!(metadata$forest_reserve %in% reserves)]
reserves_label_kort <- gsub("\\s", "_", tolower(reserves_kort))
reserves_kort_correct <- metadata[metadata$forest_reserve %in% reserves_kort,]$Correct_name

# Generate child documents
out_files <- autoqmd_generate_children(
  selected_reserve = reserves,
  label = reserves_label,
  template = "_fiche_reservaat.qmd",
  child_dir = "fiches_reservaat_qmd",
  freeze = "label"
)

# Generate child documents
out_files_kort <- autoqmd_generate_children(
  selected_reserve = reserves_kort,
  label = reserves_label_kort,
  template = "_fiche_reservaat_kort.qmd",
  child_dir = "fiches_reservaat_qmd",
  freeze = "label"
)

out_files <- c(out_files, out_files_kort)
reserves_correct <- c(reserves_correct, reserves_kort_correct)
out_files <- out_files[str_order(reserves_correct)]
reserves_correct <- sort(reserves_correct)

# insert entries into the Quarto configuration
autoqmd_insert_children(
  target_file = "_quarto.yml",
  child_files = out_files,
  child_labels = reserves_correct,
  start_marker = "# ADD-RESERVES-START",
  end_marker = "# ADD-RESERVES-END"
)
