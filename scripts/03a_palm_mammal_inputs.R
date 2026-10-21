# Focused workshop | 03a. Empirical inputs | 3 minutes

# Requires 00_setup.R. Replaces the toy distributions with palm-mammal data.

# 1. Prepared empirical inputs -------------------------------------
# The archive already matches species names, ranges, and interaction records.

input_dir <- file.path(bundle_dir, "case2")

# Custom function to normalize name formatting, then align to the matrix.
standardize_species <- function(x) {
  x <- gsub("[^[:alnum:]]+", "_", trimws(tolower(x)))
  gsub("^_+|_+$", "", x)
}


## Import fitted SBM
fit <- readRDS(file.path(input_dir, "fitted-models.rds"))

glimpse(fit)

## Observed regional metaweb
regional_web <- fit$regional_web
heatmap(regional_web)

## See inferred block from SBM 

heatmap(fit$theta_sbm)

fit$consumer_lookup |> head()
fit$producer_lookup |> head()

## Import distribution rasters

distributions <- list(
  producers = rast(file.path(input_dir, "palms.tif")),
  consumers = rast(file.path(input_dir, "mammals.tif"))
)

### Standardize sp names 
names(distributions$producers) <- standardize_species(names(distributions$producers))
names(distributions$consumers) <- standardize_species(names(distributions$consumers))

### Reorder 
distributions$producers <- distributions$producers[[rownames(regional_web)]]
distributions$consumers <- distributions$consumers[[colnames(regional_web)]]

## See raster distributions 
glimpse(distributions)

plot(distributions$producers[[8]],
     xlim = c(-90, -20),
     ylim = c(-50, 20))

maps::map("world", add = TRUE, col = "black", lwd = 0.7)

### Summary of distribution data
tibble(
  palms = nrow(regional_web),
  mammals = ncol(regional_web),
  regional_links = sum(regional_web)
)

## NOTES: 
# The regional matrix and raster species must refer to the same taxa.





