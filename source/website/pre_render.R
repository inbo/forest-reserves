library(flandersqmd)

plotinfo <- read.csv2('../../data/plotinfo.csv', header = TRUE, dec=',', sep=';')
reserves <- unique(plotinfo$forest_reserve)

# Create child document for each reserve
# Include child files in report
autoqmd_prepare(
  selected_reserve = reserves,
  label = gsub("\\s", ".", tolower(reserves)),
  template = "_fiche_reservaat.qmd",
  child_dir = "fiches_reservaat_qmd",
  qmd_file = "grafieken_per_reservaat.qmd"
)
