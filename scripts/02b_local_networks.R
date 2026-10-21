# Focused workshop | 02b. Local networks and spatial summaries | 5 minutes
# Requires 02a in this session: distributions and P.

# 2. Assemble communities and register a model --------------------
# min_species applies to EACH group. Cell 6 has no pollinators and is excluded.
# Excluded cells are different from retained communities with zero links.
assemblages <- assemble_communities(distributions, min_species = 1L)
assemblages[[1]]

# Group names must match the names in distributions.
model <- probability_matrix_model(P, row_group = "plants",
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

# QUICK QUESTION: Why can cells differ when the regional probability matrix
# is identical everywhere? Look at which species occur in each cell.
# With your own data: align names and raster geometry, and convert occurrence
# probabilities to presence/absence using a justified rule before assembly.


# Next: 03a_palm_mammal_inputs.R uses the same workflow with empirical inputs.




