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
plot(plants, main = names(plants))

# The supplied probabilities describe interactions, not species occurrence.
# Values are illustrative. MetaWeave does not fit them here.
P <- matrix(c(0.8, 0.6, 0.1, 0.2, 0.7, 0.5, 0.6, 0.2, 0.9),
            nrow = 3, byrow = TRUE,
            dimnames = list(names(plants), names(pollinators)))
P


# CHECKPOINT: Which matrix describes occurrence, and which describes interactions?
# Next: 02b_local_networks.R.



