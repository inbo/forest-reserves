library(flandersqmd)
library(knitr)
library(quarto)
library(purrr)

plotinfo <- read.csv2('../../data/plotinfo.csv', header = TRUE, dec = ',', sep = ';')
metadata <- read.csv2('../../data/metadata.csv', header = TRUE, dec = ',', sep = ';')

reserves <- sort(unique(plotinfo$forest_reserve))
reserves_label <- gsub("\\s", "_", tolower(reserves))
reserves_correct <- metadata[metadata$forest_reserve %in% reserves, "Correct_name"]

# Generate child documents
out_files <- autoqmd_generate_children(
  selected_reserve = reserves,
  label = reserves_label,
  template = "_fiche_reservaat.qmd",
  child_dir = "fiches_reservaat_qmd",
  freeze = "label"
)

# insert entries into the Quarto configuration
autoqmd_insert_children(
  target_file = "_quarto.yml",
  child_files = out_files,
  child_labels = reserves_correct,
  start_marker = "# ADD-RESERVES-START",
  end_marker = "# ADD-RESERVES-END"
)
