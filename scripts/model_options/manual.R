# Optional: specify a hypothesis about blocks and their interaction probabilities.
# Selected by the source line in 03b; requires 03a first.
# These starting assignments and probabilities are arbitrary teaching examples.
# Replace them with ecologically justified choices for a real analysis.

# 1. Start with all species in block 1.
producer_lookup <- tibble(
  species = rownames(regional_web), guild = "palm_block_1"
)
consumer_lookup <- tibble(
  species = colnames(regional_web), guild = "mammal_block_1"
)

# 2. Choose the species that belong to block 2.
# Replace these examples with vectors of exact species names from the tables.
# Example syntax: palm_block_2_species <- c("exact_name_1", "exact_name_2")
palm_block_2_species <- rownames(regional_web)[1:2]
mammal_block_2_species <- colnames(regional_web)[1:2]

producer_lookup <- producer_lookup |>
  mutate(guild = if_else(species %in% palm_block_2_species,
                         "palm_block_2", "palm_block_1"))
consumer_lookup <- consumer_lookup |>
  mutate(guild = if_else(species %in% mammal_block_2_species,
                         "mammal_block_2", "mammal_block_1"))

# 3. Supply probabilities: palm blocks in rows, mammal blocks in columns.
# Values must be between 0 and 1; block names must match the lookup tables.
# More blocks require corresponding rows or columns in this matrix.
theta_sbm <- matrix(
  c(0.10, 0.30,    # palm_block_1 with mammal blocks 1 and 2
    0.50, 0.20),   # palm_block_2 with mammal blocks 1 and 2
  nrow = 2, byrow = TRUE,
  dimnames = list(c("palm_block_1", "palm_block_2"),
                  c("mammal_block_1", "mammal_block_2"))
)
model_label <- "Manually specified block hypothesis"
# Continue in 03b to construct the model, then 03c to compare its predictions.
