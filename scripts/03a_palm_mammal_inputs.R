# Focused workshop | 03a. Empirical inputs | 3 minutes
# Requires 00_setup.R. Replaces the toy distributions with palm-mammal data.

# 1. Prepared empirical inputs -------------------------------------
# The archive already matches species names, ranges, and interaction records.
# Upstream preparation is explained in the full palm-mammal vignette.
input_dir <- file.path(bundle_dir, "case2")

fit <- readRDS(file.path(input_dir, "fitted-models.rds"))

regional_web <- fit$regional_web

distributions <- list(
  producers = rast(file.path(input_dir, "palms.tif")),
  consumers = rast(file.path(input_dir, "mammals.tif"))
)
# Normalize formatting as in the source vignette, then align to the matrix.
standardize_species <- function(x) {
  x <- gsub("[^[:alnum:]]+", "_", trimws(tolower(x)))
  gsub("^_+|_+$", "", x)
}
names(distributions$producers) <- standardize_species(names(distributions$producers))
names(distributions$consumers) <- standardize_species(names(distributions$consumers))
distributions$producers <- distributions$producers[[rownames(regional_web)]]

plot(distributions$producers[[3]])


distributions$consumers <- distributions$consumers[[colnames(regional_web)]]
tibble(
  palms = nrow(regional_web),
  mammals = ncol(regional_web),
  regional_links = sum(regional_web)
)



# The regional matrix and raster species must refer to the same taxa.
# Range overlap indicates potential co-occurrence, not confirmed encounters.
# Next: 03b_interaction_models.R.




