#!/bin/bash
#SBATCH --ntasks=30
#SBATCH --time=4320:0
#SBATCH --qos=bbdefault

set -e
module purge; module load bluebear

module load bear-apps/2024a
module load SAMtools/1.21-GCC-13.3.0

cd /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/

samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP1-BT241-DMSO_S1.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP1-BT241-DMSO_S1.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP2-BT241-DMSO_S2.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP2-BT241-DMSO_S2.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP3-BT241-DMSO_S3.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP3-BT241-DMSO_S3.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP4-BT-241-Bramaplam_S4.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP4-BT-241-Bramaplam_S4.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP5-BT-241-Bramaplam_S5.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP5-BT-241-Bramaplam_S5.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP6-BT-241-Bramaplam_S6.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP6-BT-241-Bramaplam_S6.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP7-BT-972-AAVS1_S7.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP7-BT-972-AAVS1_S7.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP8-BT-972-AAVS1_S8.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP8-BT-972-AAVS1_S8.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP9-BT-972-AAVS1_S9.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP9-BT-972-AAVS1_S9.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP10-BT-972-HTT-2-1_S10.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP10-BT-972-HTT-2-1_S10.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP11-BT-972-HTT-2-1_S11.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP11-BT-972-HTT-2-1_S11.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP12-BT-972-HTT-2-1_S12.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP12-BT-972-HTT-2-1_S12.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP13-BT-241-AAVS1_S13.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP13-BT-241-AAVS1_S13.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP14-BT-241-AAVS1_S14.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP14-BT-241-AAVS1_S14.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP15-BT-241-AAVS1_S15.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP15-BT-241-AAVS1_S15.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP16-BT-241-HTT-4-1_S16.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP16-BT-241-HTT-4-1_S16.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP17-BT-241-HTT-4-1_S17.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP17-BT-241-HTT-4-1_S17.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP18-BT-241-HTT-4-1_S18.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP18-BT-241-HTT-4-1_S18.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP19-BT-935-AAVS1_S19.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP19-BT-935-AAVS1_S19.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP20-BT-935-AAVS1_S20.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP20-BT-935-AAVS1_S20.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP21-BT-935-AAVS1_S21.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP21-BT-935-AAVS1_S21.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP22-BT-935-HTT-4-1_S22.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP22-BT-935-HTT-4-1_S22.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP23-BT-935-HTT-4-1_S23.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP23-BT-935-HTT-4-1_S23.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/MTOP24-BT-935-HTT-4-1_S24.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP24-BT-935-HTT-4-1_S24.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS1-KO-1_S25.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS1-KO-1_S25.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS2-KO-2_S26.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS2-KO-2_S26.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS3-KO-3_S27.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS3-KO-3_S27.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS4-AAVS1-1_S28.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS4-AAVS1-1_S28.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS5-AAVS1-2_S29.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS5-AAVS1-2_S29.bam
samtools view -@ 25 -b /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/SS6-AAVS1-3_S30.sam -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS6-AAVS1-3_S30.bam


samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP1-BT241-DMSO_S1_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP1-BT241-DMSO_S1.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP2-BT241-DMSO_S2_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP2-BT241-DMSO_S2.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP3-BT241-DMSO_S3_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP3-BT241-DMSO_S3.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP4-BT-241-Bramaplam_S4_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP4-BT-241-Bramaplam_S4.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP5-BT-241-Bramaplam_S5_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP5-BT-241-Bramaplam_S5.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP6-BT-241-Bramaplam_S6_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP6-BT-241-Bramaplam_S6.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP7-BT-972-AAVS1_S7_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP7-BT-972-AAVS1_S7.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP8-BT-972-AAVS1_S8_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP8-BT-972-AAVS1_S8.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP9-BT-972-AAVS1_S9_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP9-BT-972-AAVS1_S9.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP10-BT-972-HTT-2-1_S10_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP10-BT-972-HTT-2-1_S10.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP11-BT-972-HTT-2-1_S11_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP11-BT-972-HTT-2-1_S11.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP12-BT-972-HTT-2-1_S12_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP12-BT-972-HTT-2-1_S12.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP13-BT-241-AAVS1_S13_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP13-BT-241-AAVS1_S13.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP14-BT-241-AAVS1_S14_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP14-BT-241-AAVS1_S14.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP15-BT-241-AAVS1_S15_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP15-BT-241-AAVS1_S15.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP16-BT-241-HTT-4-1_S16_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP16-BT-241-HTT-4-1_S16.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP17-BT-241-HTT-4-1_S17_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP17-BT-241-HTT-4-1_S17.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP18-BT-241-HTT-4-1_S18_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP18-BT-241-HTT-4-1_S18.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP19-BT-935-AAVS1_S19_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP19-BT-935-AAVS1_S19.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP20-BT-935-AAVS1_S20_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP20-BT-935-AAVS1_S20.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP21-BT-935-AAVS1_S21_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP21-BT-935-AAVS1_S21.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP22-BT-935-HTT-4-1_S22_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP22-BT-935-HTT-4-1_S22.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP23-BT-935-HTT-4-1_S23_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP23-BT-935-HTT-4-1_S23.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP24-BT-935-HTT-4-1_S24_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP24-BT-935-HTT-4-1_S24.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS1-KO-1_S25_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS1-KO-1_S25.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS2-KO-2_S26_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS2-KO-2_S26.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS3-KO-3_S27_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS3-KO-3_S27.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS4-AAVS1-1_S28_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS4-AAVS1-1_S28.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS5-AAVS1-2_S29_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS5-AAVS1-2_S29.bam
samtools sort -@ 25 -o /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS6-AAVS1-3_S30_sorted.bam /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS6-AAVS1-3_S30.bam

samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP1-BT241-DMSO_S1_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP2-BT241-DMSO_S2_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP3-BT241-DMSO_S3_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP4-BT-241-Bramaplam_S4_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP5-BT-241-Bramaplam_S5_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP6-BT-241-Bramaplam_S6_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP7-BT-972-AAVS1_S7_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP8-BT-972-AAVS1_S8_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP9-BT-972-AAVS1_S9_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP10-BT-972-HTT-2-1_S10_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP11-BT-972-HTT-2-1_S11_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP12-BT-972-HTT-2-1_S12_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP13-BT-241-AAVS1_S13_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP14-BT-241-AAVS1_S14_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP15-BT-241-AAVS1_S15_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP16-BT-241-HTT-4-1_S16_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP17-BT-241-HTT-4-1_S17_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP18-BT-241-HTT-4-1_S18_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP19-BT-935-AAVS1_S19_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP20-BT-935-AAVS1_S20_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP21-BT-935-AAVS1_S21_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP22-BT-935-HTT-4-1_S22_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP23-BT-935-HTT-4-1_S23_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/MTOP24-BT-935-HTT-4-1_S24_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS1-KO-1_S25_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS2-KO-2_S26_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS3-KO-3_S27_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS4-AAVS1-1_S28_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS5-AAVS1-2_S29_sorted.bam
samtools index -@ 25 /rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/BAM_Samtools/SS6-AAVS1-3_S30_sorted.bam