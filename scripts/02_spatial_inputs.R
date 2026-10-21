# Focused workshop | 02a. Spatial inputs | 4 minutes
# Run 00_setup.R first. Continue in the same R session through 03c.
# Goal: distinguish species presence from interaction probability.

# 1. Prepared presence maps ---------------------------------------
# A tiny landscape: six cells, three plants, three pollinators.
# Each species has one layer, with 1 = present and 0 = absent.
# All layers must share their grid, extent, resolution, and coordinate system.
# This artificial grid uses metre coordinates; it is not an empirical map.

plants <- rast(nrows = 2, ncols = 3, nlyrs = 3,
               xmin = 0, xmax = 3000, ymin = 0, ymax = 2000,
               crs = "EPSG:3857")
values(plants) <- rbind(c(1, 1, 0), c(1, 0, 1), c(0, 1, 1),
                        c(1, 1, 1), c(1, 0, 0), c(0, 1, 0))
names(plants) <- c("Plant_A", "Plant_B", "Plant_C")

pollinators <- rast(plants)
values(pollinators) <- rbind(c(1, 1, 0), c(0, 1, 1), c(1, 0, 1),
                            c(1, 1, 1), c(0, 0, 1), c(0, 0, 0))
names(pollinators) <- c("Bee_A", "Bee_B", "Fly_A")
distributions <- list(plants = plants, pollinators = pollinators)

glimpse(distributions)


plot(plants, main = names(plants))

# The supplied probabilities describe interactions, not species occurrence.
# Values are illustrative. MetaWeave does not fit them here.

P <- matrix(c(0.8, 0.6, 0.1, 0.2, 0.7, 0.5, 0.6, 0.2, 0.9),
            nrow = 3, byrow = TRUE,
            dimnames = list(names(plants), names(pollinators)))
P


heatmap(P)

# CHECKPOINT: Which matrix describes occurrence, and which describes interactions?

# 2. Assemble communities and register a model --------------------
# min_species applies to EACH group. Cell 6 has no pollinators and is excluded.
# Excluded cells are different from retained communities with zero links.

assemblages <- assemble_communities(distributions, min_species = 1L)
assemblages[[1]]

# Group names must match the names in distributions.
model <- probability_matrix_model(P, 
                                  row_group = "plants",
                                  column_group = "pollinators")

# 3. Infer and inspect --------------------------------------------
networks <- infer_networks(assemblages, model)
networks$networks[[1]]$matrix

# Summing probabilities gives expected links; averaging gives expected
# connectance. A fractional expected count is not a partial observed link.

summarized <- summarize_networks(networks)

summarized$index |>
  select(cell_id, row_richness, column_richness,
         possible_links, expected_links, mean_probability)


summarized$networks[[1]]$matrix


# 4. The complete spatial workflow ---------------------------------
# This convenience function assembles, infers, summarizes, and maps.

spatial_result <- run_spatial_inference(distributions, model, min_species = 2L)

plot(spatial_result$spatial$data[["expected_links"]],
     main = "Expected links: at least two species per group")




