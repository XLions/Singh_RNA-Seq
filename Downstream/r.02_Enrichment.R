#bluebear的X11选项加载
options(bitmapType='cairo')

#00.清除环境变量，设置工作路径--------------------------------------------------
rm(list = ls());gc()
setwd('/rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Downstream/')
if (!dir.exists("02_Enrichment")) {dir.create("02_Enrichment")}
setwd('./02_Enrichment')


#-------------------------------Enrichment--------------------------------------
# 加载R包
suppressPackageStartupMessages({
  # ---------- Bioconductor 富集分析与注释 ----------
  library(clusterProfiler)
  library(org.Hs.eg.db)
  library(enrichplot)
  
  # ---------- 可视化与绘图 ----------
  library(ggplot2)
  library(GOplot)
  library(cowplot)
  library(patchwork)
  library(ComplexHeatmap)
  library(circlize)
  
  # ---------- 数据处理与导出 ----------
  library(tidyverse)
  library(export)
  
  # ---------- R 基础包（无需加载，可省略）----------
  # library(grid)      # 基础绘图底层支持，已默认可用
  # library(graphics)  # 基础图形系统，已默认可用
})
select=dplyr::select

# 富集用的函数
getEnrichment<-function(ensembl_with_version){
  # 去掉 .及后面的数字
  ensembl_clean <- gsub("\\..*", "", ensembl_with_version)
  
  #------------------------------GO-----------------------------------------------
  # GO富集分析####
  ## id转换
  symbol2entrezid <- bitr(geneID = ensembl_clean,
                          fromType = 'ENSEMBL',
                          toType = 'ENTREZID',
                          OrgDb = 'org.Hs.eg.db')
  pvalueCutoff <- 0.05
  qvalueCutoff <- 0.05
  
  ego <- enrichGO(gene = as.numeric(symbol2entrezid$ENTREZID),
                  keyType = "ENTREZID",
                  OrgDb = org.Hs.eg.db, 
                  pvalueCutoff = pvalueCutoff, 
                  qvalueCutoff = qvalueCutoff,
                  ont="ALL",
                  readable =TRUE)
  
  # 检查GO富集是否有结果
  if (!is.null(ego) && nrow(as.data.frame(ego)) > 0) {
    saveRDS(ego,'ego.rds')
    
    write_csv(as.data.frame(ego),"3.Rich_GO_enrich.csv")
    write_csv(as.data.frame(ego) %>% filter(pvalue <= 0.05),"4.Rich_GO_enrich_sig.csv")
    
    go.df<-as.data.frame(ego) %>% filter(pvalue <= 0.05)
    
    if (nrow(go.df) > 0) {
      go.df <- go.df %>% group_by(ONTOLOGY) %>% slice_head(n=5)
      # 使画出的GO term的顺序与输入一致
      go.df$Description <- factor(go.df$Description,levels = rev(go.df$Description))
      # 绘图 plot
      GO_Plot<-
        ggplot(data = go.df)+
        geom_point(aes(x = Description, y=(-log10(pvalue)), 
                       size = Count,color = ONTOLOGY))+
        scale_color_manual(values = c("#0000CD","orange","#43CD80"))+
        coord_flip()+
        theme_bw()+
        scale_x_discrete(labels = function(x) str_wrap(x,width = 50))+
        labs(x = "GO terms",y = paste0('-log10(P)'))+
        ggtitle('GO Enrichment')+
        ggplot2::theme(axis.title = element_text(size = 13),
                       axis.text = element_text(size = 11),
                       plot.title = element_text(size = 10,hjust = 0.5,face = "bold"),
                       legend.title = element_text(size = 10),
                       legend.text = element_text(size = 10))
      ggsave('5.GO_bubble.pdf',GO_Plot,width = 10,height=6)
      ggsave('5.GO_bubble.png',GO_Plot,width = 10,height=6,dpi=600)
    } else {
      message("No significant GO terms found (pvalue <= 0.05), skip GO bubble plot.")
    }
  } else {
    message("No GO enrichment results, skip all GO steps.")
  }
  
  #----------------------------KEGG-----------------------------------------------
  # kegg 富集分析 #### 
  ekegg <- enrichKEGG(gene = symbol2entrezid$ENTREZID ,
                      keyType = "kegg",
                      organism = "hsa",
                      pAdjustMethod = "BH",
                      pvalueCutoff = 0.05,
                      qvalueCutoff = 0.05)
  
  # 检查KEGG富集是否有结果
  if (!is.null(ekegg) && nrow(as.data.frame(ekegg)) > 0) {
    saveRDS(ekegg,'ekegg.rds')
    
    ekegg_sig<-as.data.frame(ekegg) %>% filter(pvalue < 0.05)
    
    ekegg2 <- setReadable(ekegg, OrgDb = org.Hs.eg.db, keyType="ENTREZID")
    write_csv(as.data.frame(ekegg2),"6.KEGG_enrich.csv")
    
    kegg.df <- ekegg2[order(ekegg2$pvalue),]
    if (nrow(kegg.df) > 0) {
      kegg.df$Y_Axis_Value<-kegg.df[,which(colnames(kegg.df)=='pvalue')]
      #计算数值型GeneRatio
      kegg.df$GeneRatio_Number<-NA
      for (i in 1:nrow(kegg.df)) {
        kegg.df$GeneRatio_Number[i]<-
          as.numeric(
            str_sub(kegg.df$GeneRatio[i],1,str_locate_all(kegg.df$GeneRatio[i],'/')[[1]][1,1]-1)
          )/as.numeric(
            str_sub(kegg.df$GeneRatio[i],
                    str_locate_all(kegg.df$GeneRatio[i],'/')[[1]][1,1]+1,
                    nchar(kegg.df$GeneRatio[i]))
          )
      }
      
      kegg_df_top<-kegg.df %>% 
        slice_head(n=10)
      if (nrow(kegg_df_top) > 0) {
        kegg_df_top$Description <- factor(kegg_df_top$Description,levels = rev(kegg_df_top$Description))
        KEGG_Plot<-
          ggplot(data = kegg_df_top)+
          geom_point(aes(x = Description, y=GeneRatio_Number, size = Count,color = (-log10(pvalue))))+
          scale_color_gradient(low="blue",high="red")+
          coord_flip()+
          theme_bw()+
          scale_x_discrete(labels = function(x) str_wrap(x,width = 50))+
          labs(x = "KEGG terms",y = "GeneRatio", 
               color = paste0('-log10(P)'))+
          ggtitle('KEGG Enrichment')+
          ggplot2::theme(axis.title = element_text(size = 13),
                         axis.text = element_text(size = 11),
                         plot.title = element_text(size = 10,hjust = 0.5,face = "bold"),
                         legend.title = element_text(size = 10),
                         legend.text = element_text(size = 10))
        ggsave('7.KEGG_bubble.pdf',KEGG_Plot,width = 10,height=6)
        ggsave('7.KEGG_bubble.png',KEGG_Plot,width = 10,height=6,dpi=600)
      } else {
        message("No KEGG terms left after top 10 slice, skip KEGG bubble plot.")
      }
    } else {
      message("KEGG enrichment result is empty, skip KEGG bubble plot.")
    }
  } else {
    message("No KEGG enrichment results, skip all KEGG steps.")
  }
}

# 建立比较组
compares<-c(
  'BT241_DSMO_Drug',
  'BT972_AAVS1_HTT2-1(KO)',
  'BT241_AAVS1_HTT4-1(KO)',
  'BT935_AAVS1_HTT4-1(KO)',
  'SS_AAVS1_ROBO1(KO)'
)

# 建立循环进行分析
for(i in 1:length(compares)){
  if(!dir.exists(compares[i])){dir.create(compares[i])};setwd(compares[i])
  
  DEGs_res1<-read.csv(paste0('../../01_DEGs/',compares[i],'/1.DESeq2_res1.csv'),
                      row.names = 1)
  getEnrichment(rownames(DEGs_res1)[which(DEGs_res1$Change!='Stable')])
  setwd('../')
}

