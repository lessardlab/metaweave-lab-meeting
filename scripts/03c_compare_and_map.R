# Focused workshop | 03c. Compare and map | 7 minutes, including questions
# Run after 03b. Where do interaction assumptions lead to different predictions?

# 1. Apply both models to the same communities --------------------------------
recorded_networks <- infer_networks(assemblages, recorded_model)
block_networks <- infer_networks(assemblages, sbm_model)

recorded_summary <- summarize_networks(recorded_networks)
block_summary <- summarize_networks(block_networks)

# 2. Match predictions by geographic cell -------------------------------------
# Join using cell_id so each comparison refers to the same location.
recorded_cells <- recorded_summary$index |>
  select(cell_id, x, y, expected_links) |>
  rename(recorded_links = expected_links)

block_cells <- block_summary$index |>
  select(cell_id, expected_links) |>
  rename(expected_sbm_links = expected_links)

# Negative differences mean fewer expected links under the block model.
cells <- recorded_cells |>
  left_join(block_cells, by = "cell_id") |>
  mutate(additional_expected_links = expected_sbm_links - recorded_links)

# 3. Summarize and map the comparison -----------------------------------------
# Compare expected links: sum of each local matrix, binary or probabilistic.
cells |>
  summarise(
    cells = n(),
    mean_recorded_links = mean(recorded_links),
    mean_expected_sbm_links = mean(expected_sbm_links)
  )

# Put the two predictions into one column: one row per cell and model.
# This lets facet_wrap() draw a separate map for each model.
map_data <- cells |>
  select(cell_id, x, y, recorded_links, expected_sbm_links) |>
  rename(`Recorded baseline` = recorded_links,
         `Block model` = expected_sbm_links) |>
  pivot_longer(
    cols = c(`Recorded baseline`, `Block model`),
    names_to = "model",
    values_to = "links"
  )
print(ggplot(map_data, aes(x, y, fill = links)) +
  geom_tile() + facet_wrap(~ model) + coord_equal() +
  scale_fill_viridis_c() + theme_minimal() +
  labs(x = "Longitude", y = "Latitude", fill = "Links",
       title = "Same communities; shared colour scale",
       subtitle = model_label))

limit <- max(1, abs(cells$additional_expected_links))

print(ggplot(cells, aes(x, y, fill = additional_expected_links)) +
  geom_tile() + coord_equal() + theme_minimal() +
  scale_fill_gradient2(low = "#2166AC", mid = "white", high = "#B2182B",
                       limits = c(-limit, limit), midpoint = 0) +
  labs(x = "Longitude", y = "Latitude", fill = "Difference",
       title = "Expected block-model links minus recorded-baseline links",
       subtitle = model_label))

# 4. Interpretation ----------------------------------------------
# ASK: Does a negative difference mean the SBM cannot predict unrecorded pairs?
# No: the total also includes reductions in the contribution of recorded pairs.
# Neither map establishes realized encounters or seed-dispersal effectiveness.
# Independent local observations would be needed to evaluate predictive accuracy.
# Blank cells fail the assemblage criterion; they are not necessarily zero links.


# FINAL DISCUSSION: What inputs would you replace for your own study?
# What local observations would help evaluate these predictions?
# Choose another source line in 03b (or edit manual parameters), then rerun 03b and 03c.




