# Focused MetaWeave workshop

Scientific question: **how do species distributions and interaction assumptions combine to shape local networks?**

## Folder layout

```text
focused_workshop/
  introduction.qmd                 Reveal.js introduction, about 6 minutes
  README.md
  scripts/
    00_setup.R
    02a_spatial_inputs.R
    02b_local_networks.R
    03a_palm_mammal_inputs.R
    03b_interaction_models.R
    03c_compare_and_map.R
    model_options/
      archived.R
      cassandRa.R
      manual.R
  data/
    case2/                         Palm–mammal workshop inputs
    case3/                         Other supplied bundle materials, unused here
    provenance/
    manifest.csv
    README.md
```

The existing local data bundle was moved intact into `data/`, preserving its documentation and manifest. Original workshop scripts outside this focused folder remain separate.

## Introduction slides

`introduction.qmd` contains a title slide and eight content slides, timed to approximately six minutes. It follows the introduction in `article.qmd`: ecological interactions, regional metawebs, the need for a common workflow, and MetaWeave's modular design. It then presents the main functions for assemblage construction, model definition, inference, and spatial summaries. Case-study illustrations are reserved for the practical scripts.

Render from this folder when you are ready:

```sh
quarto render introduction.qmd --to revealjs
```

Open `introduction.html` and press **S** for speaker view. The QMD contains no executable R chunks and disables execution. It uses inline styling and no external image files. The source has not been rendered or visually tested during this edit.

## Setup and run order

Set RStudio's working directory to **focused_workshop**, not `scripts/`. Use Session > Set Working Directory > Choose Directory. Open `scripts/00_setup.R`, then work through the scripts in one fresh R session. Paths are relative to this main folder: `bundle_dir <- "data"` and model alternatives under `scripts/model_options/`.

Required packages: `metaweave`, `terra`, `ggplot2`, `dplyr`, and `tidyr`. Install them before teaching. The optional cassandRa fitting route requires that package separately. Scripts share objects and should be run in order.

A suggested schedule keeps the introduction within the original 30-minute total:

| Material | Minutes | Scientific focus |
|---|---:|---|
| `scripts/00_setup.R` | Before session | Packages and data location |
| `introduction.qmd` | 6 | Scientific motivation and interpretation |
| `scripts/02a_spatial_inputs.R` | 4 | Species presence versus interaction probability |
| `scripts/02b_local_networks.R` | 5 | Local assemblages, matrices, and maps |
| `scripts/03a_palm_mammal_inputs.R` | 3 | Empirical ranges and regional records |
| `scripts/03b_interaction_models.R` | 5 | Different interaction assumptions on the same community |
| `scripts/03c_compare_and_map.R` | 7 | Spatial comparison and discussion |

Timing is a teaching target, not measured runtime. Use brief questions during the walkthrough; manual model exploration and refitting are extensions.

## Model alternatives

03b has three `source()` lines. Keep exactly one active:

- `scripts/model_options/archived.R`: saved fitted memberships and probabilities; the live-session default.
- `scripts/model_options/cassandRa.R`: externally fit the regional matrix, allowing additional time.
- `scripts/model_options/manual.R`: edit species memberships and between-block probabilities. Initial values are arbitrary teaching examples.

All routes supply parameters to MetaWeave's `block_model()`; MetaWeave does not fit the SBM. After changing a model choice or manual values, rerun 03b and 03c. The latter calculates results for the chosen model and joins predictions by cell identifier before mapping.

Table operations use dplyr and tidyr; matrix and raster operations retain their native syntax. Read `|>` as “then.” The scripts do not save results, clear the workspace, or change the working directory.

No R code was executed during reorganization. Run the sequence yourself before teaching to check installed packages and pacing.

