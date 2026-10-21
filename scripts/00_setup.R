# Focused MetaWeave workshop | Setup before the session

# In RStudio, open this script and choose:
# Session > Set Working Directory > Choose Directory, then select focused_workshop.
# Run the workshop scripts in order, in the same R session.

# Install packages beforehand if needed (run these lines manually):
# install.packages(c("remotes", "terra", "ggplot2", "dplyr", "tidyr", "metaweave"))


library(metaweave)
library(terra)
library(ggplot2)
library(dplyr)
library(tidyr)

# Read |> as "then": take a table, then select, join, or summarize its columns.

# Paths below are relative to the focused_workshop folder.
# Edit this path if your data are elsewhere.
bundle_dir <- "data"



