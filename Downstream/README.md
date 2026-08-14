# Downstream — Bulk RNA-seq Analysis (260306_Singh-RNAseq)

Downstream analysis of the bulk RNA-seq dataset, starting from the `featureCounts` matrix
produced by the upstream pipeline. Covers quality assessment, differential gene expression
(DESeq2) and functional enrichment (GO / KEGG) across five pairwise comparisons.

**Maintainer:** Zhaoshuo Liu · **Supervisor:** Dr. Deena Gendoo

---

## Experimental design

30 samples (S1–S30) organised into five comparison groups of six (3 control + 3 case):

| # | Comparison | Cell line | Control | Case |
|---|------------|-----------|---------|------|
| 1 | `BT241_DSMO_Drug` | BT 241 | DMSO vehicle | Drug |
| 2 | `BT972_AAVS1_HTT2-1(KO)` | BT 972 | AAVS1 | HTT2-1 KO |
| 3 | `BT241_AAVS1_HTT4-1(KO)` | BT 241 | AAVS1 | HTT4-1 KO |
| 4 | `BT935_AAVS1_HTT4-1(KO)` | BT 935 | AAVS1 | HTT4-1 KO |
| 5 | `SS_AAVS1_ROBO1(KO)` | SS | AAVS1 | ROBO1 KO |

Group membership is read from `Data/RNA Seq Form.xlsx` and resolved to sample IDs in
`r_00_PreProcess.R`. Each script writes into its own numbered output folder.

---

## Scripts

Run in order. Each script is self-contained and assumes the working directory is
`Downstream/`.

### `r_00_PreProcess.R` → `00_PreProcess/`

Prepares the expression matrices and performs first-pass QC.

- Reads `Matrix_featureCounts/all_samples_counts.txt`, strips the BAM path prefixes from
  the column names down to bare sample IDs (`S1` … `S30`).
- Converts raw counts to FPKM (depth normalisation followed by gene-length normalisation
  using the `Length` column from featureCounts).
- Parses the sample sheet into a tidy group table (`Cell`, `Treatment`, `DETAILS`,
  `Sample`, `Group`, `CompareGroup`).
- PCA on log2(FPKM + 1), coloured by individual condition and by comparison group.
- Read-assignment summary from `all_samples_counts.txt.summary` as a 100% stacked bar chart.

**Outputs:** `counts.csv/.RDS`, `fpkm.csv/.RDS`, `group.csv/.RDS`,
`1.PCA_plot_AllSamples_bySample.*`, `2.PCA_plot_AllSamples_byCompare.*`,
`3.Assignment_Rate_Plot.*`

### `r_01_DGEs.R` → `01_DEGs/<comparison>/`

Differential expression with DESeq2, looped over the five comparisons via the `getDEGs()`
function.

- Builds a per-comparison count matrix and `colData` (`Control` as the reference level).
- `DESeq()` with default settings (parametric dispersion fit, no outlier replacement).
- Annotates results with gene symbols (`bitr`, `org.Hs.eg.db`); genes without a mapping
  keep their Ensembl ID as the plotting label.
- Classifies genes as `Up` / `Down` / `Stable` using the supplied p-value and log2FC cutoffs.
- Volcano plots and top-20 (10 up + 10 down) density heatmaps, in both Ensembl-ID and
  gene-symbol flavours. Heatmaps are built on VST-transformed counts.
- A Venn diagram of DEG overlap across all five comparisons.

**Current thresholds:** `P_Type = 'Adjust'`, `PValue_cutoff = 0.05`, `logFC_cutoff = 1`

**Outputs per comparison:** `1.DESeq2_res1.csv`, `2.DEGs_volcano.*`,
`3.DEGs_deg_top_heatmap.*`, `4.DEGs_volcano_symbol.*`,
`5.DEGs_deg_top_heatmap_symbol.*`
**Outputs at folder level:** `Venn_Diagram_DEGs.*`

### `r_02_Enrichment.R` → `02_Enrichment/<comparison>/`

Over-representation analysis on the DEGs of each comparison.

- Ensembl IDs (version stripped) → Entrez IDs via `bitr`.
- `enrichGO` across all three ontologies (`ont = "ALL"`), and `enrichKEGG` for *H. sapiens*,
  both at p < 0.05 / q < 0.05.
- Bubble plots at two levels of detail so that figures can be used both for slides
  (compact) and for supplementary material (fuller).

**Outputs per comparison:** `ego.rds`, `1.Rich_GO_enrich.csv`,
`2.Rich_GO_enrich_sig.csv`, `3.GO_bubble_top5.*`, `4.GO_bubble_top10.*`, `ekegg.rds`,
`5.KEGG_enrich.csv`, `6.KEGG_bubble_top10.*`, `7.KEGG_bubble_top20.*`

---

## Environment

Run on BlueBEAR. `options(bitmapType = 'cairo')` is set at the top of every script for
headless plotting.

Core packages: `DESeq2`, `clusterProfiler`, `org.Hs.eg.db`, `enrichplot`,
`ComplexHeatmap`, `tidyverse`, `ggrepel`, `ggVennDiagram`, `export`, `openxlsx`.

`enrichKEGG` queries the KEGG REST API and therefore needs outbound network access — run
`r_02_Enrichment.R` from a login node, or cache the KEGG annotation locally first.


---

## Changelog

### 2026-08-14

Code review and correctness fixes across all three scripts.

**`r_00_PreProcess.R`**
- Fixed `write.csv(..., row.names = FALSE)` for `counts.csv` and `fpkm.csv`. Gene IDs had
  been moved to row names beforehand, so the exported CSVs contained no gene identifiers
  at all. Both now export with row names.

**`r_01_DGEs.R`**
- **Reverted DESeq2 to default parameters.** The previous call used
  `fitType = 'mean'` and `minReplicatesForReplace = 3`. A single shared dispersion across
  all genes discards DESeq2's dispersion shrinkage, and Cook's-distance outlier
  replacement is not recommended below ~7 replicates; with n = 3 it deflates dispersion
  estimates and inflates significance. Now simply `DESeq(dds)`.
- Fixed the group-label constructor: `rep(c('Control','Case'), each = c(n1, n2))` →
  `times = c(n1, n2)`. `each` only accepts a length-1 value, so R was silently using the
  first element; this happened to be correct for balanced 3-vs-3 designs but would have
  mislabelled samples in any unbalanced comparison. Added a `stopifnot()` guard on
  non-empty sample vectors.
- Removed the hard axis limits from both volcano plots (`limits = c(-7, 7)` on x,
  `limits = c(0, 10)` on y). `scale_*_continuous(limits =)` drops points outside the range
  rather than zooming, so the most significant genes were being silently deleted from the
  figure — 120 genes exceeded `-log10(padj) = 10`, the largest at 51.2.
- Both top-gene heatmaps now use VST-transformed counts. The symbol-labelled heatmap was
  still z-scoring raw counts, which encodes library-size differences rather than
  expression differences and made it inconsistent with its Ensembl-labelled counterpart.
- Duplicate gene symbols in heatmap row names are now disambiguated with `make.unique()`;
  several Ensembl IDs can map to the same symbol.

**`r_02_Enrichment.R`**
- Added fuller bubble plots alongside the existing compact ones — GO top 10 per ontology
  (`4.GO_bubble_top10`) and KEGG top 20 (`7.KEGG_bubble_top20`) — so that figures show
  more of the genesets passing the significance threshold, per feedback from the meeting
  with Sheila's team. KEGG plot filenames were also disambiguated; the previous version
  wrote the top-10 and all-terms plots to the same path, so only the latter survived.

