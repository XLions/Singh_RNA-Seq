#!/bin/bash
#SBATCH --ntasks=30
#SBATCH --time=4320:0
#SBATCH --qos=bbdefault

set -e
module purge; module load bluebear

module load bear-apps/2022a
module load Subread/2.0.4-GCC-11.3.0

# 1. 设置路径变量 (请确保 GTF 路径正确)
GTF_FILE="/rds/projects/g/gendood-preclinomics/EHMT2/References_Index/references/gencode.v45.annotation.gtf"
OUT_DIR="/rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Matrix_featureCounts"

# 2. 创建输出文件夹
# mkdir -p ${OUT_DIR}

# 3. 运行 featureCounts 生成表达量矩阵
# 参数解释:
# -T 25  : 使用 25 个线程加速
# -p     : 声明这是双端测序 (Paired-end data)，极其重要！
# -s 2   : 链特异性参数。0=非链特异性，1=正义链，2=反义链(dUTP法通常是2)。如果不确定，可以改为 -s 0
# -a     : 输入基因组注释 GTF 文件
# -o     : 指定输出的矩阵文件名

featureCounts -T 25 -p -s 2 \
    -a ${GTF_FILE} \
    -o ${OUT_DIR}/all_samples_counts.txt \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP1-BT241-DMSO_S1_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP2-BT241-DMSO_S2_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP3-BT241-DMSO_S3_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP4-BT-241-Bramaplam_S4_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP5-BT-241-Bramaplam_S5_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP6-BT-241-Bramaplam_S6_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP7-BT-972-AAVS1_S7_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP8-BT-972-AAVS1_S8_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP9-BT-972-AAVS1_S9_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP10-BT-972-HTT-2-1_S10_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP11-BT-972-HTT-2-1_S11_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP12-BT-972-HTT-2-1_S12_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP13-BT-241-AAVS1_S13_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP14-BT-241-AAVS1_S14_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP15-BT-241-AAVS1_S15_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP16-BT-241-HTT-4-1_S16_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP17-BT-241-HTT-4-1_S17_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP18-BT-241-HTT-4-1_S18_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP19-BT-935-AAVS1_S19_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP20-BT-935-AAVS1_S20_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP21-BT-935-AAVS1_S21_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP22-BT-935-HTT-4-1_S22_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP23-BT-935-HTT-4-1_S23_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP24-BT-935-HTT-4-1_S24_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS1-KO-1_S25_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS2-KO-2_S26_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS3-KO-3_S27_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS4-AAVS1-1_S28_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS5-AAVS1-2_S29_sorted.bam \
    /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS6-AAVS1-3_S30_sorted.bam