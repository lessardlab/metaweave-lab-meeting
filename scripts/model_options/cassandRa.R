# Optional: fit the regional interaction matrix with cassandRa.
# Selected by the source line in 03b; requires 03a first.
# Install cassandRa separately. The original vignette used version 0.2.0.
# This fitting step takes additional time beyond the live walkthrough.

# install.packages('cassandRa')

cass_network <- cassandRa::CreateListObject(regional_web)
set.seed(123)

cat('Fitting model\n')

cass_fit <- cassandRa::FitSBM(
  list = cass_network,
  n_SBM = 10,
  G = NULL
)



# Ten optimization runs search for a fit; they are not ecological replicates.
# G = NULL uses the implementation's default block-number selection.
# Extract the selected fit, its probabilities, and species memberships.

best_sbm <- cass_fit$SBM1
theta_sbm <- best_sbm$Omega_rs
producer_blocks <- paste0("producer_block_", seq_len(nrow(theta_sbm)))
consumer_blocks <- paste0("consumer_block_", seq_len(ncol(theta_sbm)))
dimnames(theta_sbm) <- list(producer_blocks, consumer_blocks)

producer_lookup <- tibble(
  species = rownames(regional_web),
  guild = producer_blocks[best_sbm$SB_H]
)
consumer_lookup <- tibble(
  species = colnames(regional_web),
  guild = consumer_blocks[best_sbm$SB_W]
)
model_label <- "New cassandRa fit"


cat('Done\n')

