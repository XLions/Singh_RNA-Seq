library(tidyverse)

log<-read.delim('../BashFiles/slurm-41273133.out')

startLines<-c()
for(i in 1:nrow(log)){startLines<-c(startLines,
                                    str_detect(log[i,],'reads; of these:'))}
startLines<-which(startLines)
startLines<-c(0,startLines)

startLines_check<-c() 
for(i in 2:length(startLines)){
  startLines_check<-c(
    startLines_check,
    (startLines[i]-startLines[i-1])==(startLines[i-1]-startLines[i-2])
  )
}#应该是除了第一个都是T

startLines<-startLines[-which(startLines==0)]

ORLines<-c()
for(i in 1:nrow(log)){ORLines<-c(ORLines,
                                    str_detect(log[i,],'overall alignment rate'))}
ORLines<-which(ORLines)
ORs<-str_remove_all(log[ORLines,] %>% as.character(),
                    '% overall alignment rate') %>% as.numeric()

sample_bash<-readLines('../BashFiles/SAM_Bowtie2.sh')
sample_bash<-sample_bash[which(str_detect(sample_bash,'bowtie2 -p 25 -x '))]
samples <- str_extract(sample_bash, "(?<=-S\\s)[^\\s]+") %>%
  str_remove_all('/rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/SAM_Bowtie2/')

plot_data<-data.frame(
  Samples=samples,
  Rate=ORs/100
)
plot_data$Samples<-factor(plot_data$Samples,levels=samples)

ggplot(data=plot_data)+
  geom_col(aes(x=Samples,y=Rate),color='black',fill='deepskyblue')+
  theme_bw()+
  labs(y='Overall Aligment Rate')+
  geom_hline(yintercept = 0.85, linetype='dashed')+
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    axis.title = element_text(face = 'bold')
  )
ggsave('OverallAlignmentRate.svg',height=5,width = 7)
ggsave('OverallAlignmentRate.png',height=5,width = 7,dpi=600)

