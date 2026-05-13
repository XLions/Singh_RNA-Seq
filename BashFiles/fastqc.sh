#!/bin/bash
#SBATCH --ntasks=15
#SBATCH --time=80:0
#SBATCH --qos=bbdefault

set -e
module purge; module load bluebear

module load bear-apps/2023a
module load FastQC/0.11.9-Java-11

cd /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/

fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP10-BT-972-HTT-2-1_S10_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP10-BT-972-HTT-2-1_S10_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP11-BT-972-HTT-2-1_S11_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP11-BT-972-HTT-2-1_S11_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP12-BT-972-HTT-2-1_S12_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP12-BT-972-HTT-2-1_S12_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP13-BT-241-AAVS1_S13_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP13-BT-241-AAVS1_S13_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP14-BT-241-AAVS1_S14_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP14-BT-241-AAVS1_S14_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP15-BT-241-AAVS1_S15_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP15-BT-241-AAVS1_S15_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP16-BT-241-HTT-4-1_S16_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP16-BT-241-HTT-4-1_S16_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP17-BT-241-HTT-4-1_S17_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP17-BT-241-HTT-4-1_S17_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP18-BT-241-HTT-4-1_S18_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP18-BT-241-HTT-4-1_S18_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP19-BT-935-AAVS1_S19_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP19-BT-935-AAVS1_S19_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP1-BT241-DMSO_S1_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP1-BT241-DMSO_S1_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP20-BT-935-AAVS1_S20_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP20-BT-935-AAVS1_S20_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP21-BT-935-AAVS1_S21_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP21-BT-935-AAVS1_S21_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP22-BT-935-HTT-4-1_S22_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP22-BT-935-HTT-4-1_S22_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP23-BT-935-HTT-4-1_S23_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP23-BT-935-HTT-4-1_S23_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP24-BT-935-HTT-4-1_S24_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP24-BT-935-HTT-4-1_S24_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP2-BT241-DMSO_S2_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP2-BT241-DMSO_S2_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP3-BT241-DMSO_S3_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP3-BT241-DMSO_S3_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP4-BT-241-Bramaplam_S4_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP4-BT-241-Bramaplam_S4_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP5-BT-241-Bramaplam_S5_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP5-BT-241-Bramaplam_S5_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP6-BT-241-Bramaplam_S6_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP6-BT-241-Bramaplam_S6_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP7-BT-972-AAVS1_S7_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP7-BT-972-AAVS1_S7_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP8-BT-972-AAVS1_S8_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP8-BT-972-AAVS1_S8_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP9-BT-972-AAVS1_S9_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/MTOP9-BT-972-AAVS1_S9_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS1-KO-1_S25_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS1-KO-1_S25_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS2-KO-2_S26_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS2-KO-2_S26_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS3-KO-3_S27_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS3-KO-3_S27_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS4-AAVS1-1_S28_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS4-AAVS1-1_S28_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS5-AAVS1-2_S29_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS5-AAVS1-2_S29_L001_R2_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS6-AAVS1-3_S30_L001_R1_001.fastq.gz
fastqc -t 12 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/QualityControl/FastQC/ /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Data/SS6-AAVS1-3_S30_L001_R2_001.fastq.gz
