library(flandersqmd)
library(knitr)
library(quarto)
library(purrr)

plotinfo <- read.csv2('../../data/plotinfo.csv', header = TRUE, dec = ',', sep = ';')
metadata <- read.csv2('../../data/metadata.csv', header = TRUE, dec = ',', sep = ';')

reserves <- unique(plotinfo$forest_reserve)
reserves_lower <- gsub("\\s", "_", tolower(reserves))
reserves_correct <- metadata[metadata$forest_reserve %in% reserves, "Correct_name"]

autoqmd_generate_children(
  selected_reserve = reserves,
  label = gsub("\\s", "_", tolower(reserves)),
  template = "_fiche_reservaat.qmd",
  child_dir = "fiches_reservaat_qmd",
  freeze = "label"
)

yml_text <- readLines("_quarto_template.yml")
to_replace <- yml_text[grepl("<<<ADD RESERVES>>>", yml_text)]
to_add <- character(0)
for (i in seq_along(reserves)) {
  to_add <- c(
    to_add,
    gsub("<<<ADD RESERVES>>>", paste("text:", reserves_correct[i]), to_replace),
    gsub("- <<<ADD RESERVES>>>", paste0("  file: fiches_reservaat_qmd/", reserves_lower[i], ".qmd"), to_replace)
  )
}
place <- which(yml_text == to_replace)
c(yml_text[1:(place-1)], to_add, yml_text[(place+1):length(yml_text)]) |>
  writeLines("_quarto.yml")


