# Focused workshop | 03b. Interaction assumptions | 5 minutes
# Run after 03a. Question: what changes when the species stay the same,
# but we change our assumptions about their interactions?

# 1. Recorded-link baseline --------------------------------------------------
# A recorded regional pair receives 1 wherever both species co-occur.
recorded_model <- probability_matrix_model(
  regional_web, row_group = "producers", column_group = "consumers"
)

# 2. Choose how to supply the blocks and their probabilities -----------------
# Run ONE source line. Use the archived fit for the main walkthrough.
# To try another option, comment out the first line and uncomment your choice.

source("scripts/model_options/archived.R")
# source("scripts/model_options/cassandRa.R")
# source("scripts/model_options/manual.R")

# Each species belongs to a block. Theta describes probabilities between blocks.
# 'guild' here means block membership, not the broad palm or mammal group.
head(producer_lookup)
head(consumer_lookup)
round(theta_sbm, 2)

# MetaWeave uses the supplied parameters; it does not fit the SBM.
sbm_model <- block_model(
  row_lookup = producer_lookup,
  column_lookup = consumer_lookup,
  theta = theta_sbm,
  row_group = "producers",
  column_group = "consumers"
)

# 3. Compare the same local community under both models ----------------------
assemblages <- assemble_communities(distributions, min_species = 1L)
one_recorded <- infer_networks(assemblages[1], recorded_model)
one_sbm <- infer_networks(assemblages[1], sbm_model)

one_recorded$networks[[1]]$matrix
round(one_sbm$networks[[1]]$matrix, 2)

# A recorded 1 can become a probability below 1; an unrecorded 0 can receive
# positive probability. Neither operation changes the species present.
# QUESTION: Can total expected links decrease even with new potential pairs?
# Next: 03c_compare_and_map.R.


