# Quality Control
Because the dataset type is **RNA-Seq**, where a single gene can correspond to multiple transcripts, sequencing duplication levels are **NOT** on the list of factors to consider for QC. For RNA-Seq datasets, it is the per-file **Mean Quality Score** and **Adapter Content** that need to be considered.

## Mean Quality Score
The curve for each file falls within the green area. Therefore, the quality scores indicate that each file is of sufficient quality for downstream analysis. No abnormally low-quality samples were detected.
![Mean Quality Score](https://github.com/XLions/Singh_RNA-Seq/blob/6b54c1cf8f794816dbf0ff7c353d234bb6342b52/QualityControl/MultiQC/fastqc_per_base_sequence_quality_plot.svg)
  
## Adapter Content
The curve for each file falls within the green area. All curves lie very close to the X-axis, which represents zero adapter content. Therefore, each file is clean and requires no adapter trimming.
![Adapter Content](https://github.com/XLions/Singh_RNA-Seq/blob/6b54c1cf8f794816dbf0ff7c353d234bb6342b52/QualityControl/MultiQC/fastqc_adapter_content_plot.svg)

## Summary of Others
* **Per Sequence Quality Scores:** All files show green curves. No further action is needed.  
* **Per Sequence GC Content:** Most curves are green, with no red curves. No further action is needed.  
* **Per Base N Content:** All curves are green and fall within the green area. No further action is needed.  
