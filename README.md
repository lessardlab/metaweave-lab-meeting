# Focused MetaWeave workshop

Scientific question: **how do species distributions and interaction assumptions combine to shape local networks?**

## Folder layout

```text
metaweave-lab-meeting/
  index.qmd                 Reveal.js introductory presentation
  README.md
  scripts/
    00_setup.R
    02_spatial_inputs.R
    03a_palm_mammal_inputs.R
    03b_interaction_models.R
    03c_compare_and_map.R
    model_options/
      archived.R
      cassandRa.R
      manual.R
  data/
    case2/                         Palm–mammal workshop inputs
    case3/                         Other supplied bundle materials, unused for this workshop
    provenance/
```

## Introduction slides

Render from this folder when you are ready:

```sh
quarto render index.qmd --to revealjs
```

or open the live version at

[https://lessardlab.github.io/metaweave-lab-meeting/](https://lessardlab.github.io/metaweave-lab-meeting/)


## Setup and run order

Set RStudio's working directory to **metaweave_lab_meeting**, not `scripts/`. Use Session > Set Working Directory > Choose Directory. Open `scripts/00_setup.R`, then work through the scripts in one fresh R session. Paths are relative to this main folder: `bundle_dir <- "data"` and model alternatives under `scripts/model_options/`.

Required packages: `metaweave`, `terra`, `ggplot2`, `dplyr`, and `tidyr`. Install them before teaching. The optional cassandRa fitting route requires that package separately. Scripts share objects and should be run in order.


| Material | Minutes | Scientific focus |
|---|---:|---|
| `scripts/00_setup.R` | Before session | Packages and data location |
| `introduction.qmd` | 6 | Scientific motivation and interpretation |
| `scripts/02_spatial_inputs.R` | 4 | Species presence versus interaction probability |
| `scripts/03a_palm_mammal_inputs.R` | 3 | Empirical ranges and regional records |
| `scripts/03b_interaction_models.R` | 5 | Different interaction assumptions on the same community |
| `scripts/03c_compare_and_map.R` | 7 | Spatial comparison and discussion |

Timing is a teaching target, not measured runtime. 


## Model alternatives

03b has three `source()` lines. Keep exactly one active:

- `scripts/model_options/archived.R`: saved fitted memberships and probabilities; the live-session default.
- `scripts/model_options/cassandRa.R`: externally fit the regional matrix, allowing additional time.
- `scripts/model_options/manual.R`: edit species memberships and between-block probabilities. Initial values are arbitrary teaching examples.

All routes supply parameters to MetaWeave's `block_model()`; MetaWeave does not fit the SBM. After changing a model choice or manual values, rerun 03b and 03c. The latter calculates results for the chosen model and joins predictions by cell identifier before mapping.

Table operations use dplyr and tidyr; matrix and raster operations retain their native syntax. Read `|>` as “then.” The scripts do not save results, clear the workspace, or change the working directory.

