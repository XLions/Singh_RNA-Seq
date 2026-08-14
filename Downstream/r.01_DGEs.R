#bluebear的X11选项加载
options(bitmapType='cairo')

setwd('/rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Downstream/')

rm(list = ls());gc()
folder<-'01_DEGs';if(!dir.exists(folder)){dir.create(folder)};setwd(folder)

library(tidyverse)

# 建立差异基因分析的函数
getDEGs<-function(case_condition,
                  control_condition,
                  counts_input,
                  group_input,
                  P_Type=c('Raw','Adjust'),
                  PValue_cutoff,
                  logFC_cutoff){
  
  #加载R包
  library(limma)
  library(DESeq2)
  library(tidyverse)
  library(ggrepel)
  library(psych)
  library(corrplot)
  library(ComplexHeatmap)
  library(clusterProfiler)
  library(org.Hs.eg.db)   # 请根据物种修改
  select=dplyr::select
  
  
  # 检索对应样本ID
  case_sample<-group_input$Sample[which(group_input$DETAILS==case_condition)]
  control_sample<-group_input$Sample[which(group_input$DETAILS==control_condition)]
  
  # 拼接对应的表达矩阵
  countData<-cbind(
    counts_input %>% dplyr::select(control_sample),
    counts_input %>% dplyr::select(case_sample)
  )
  
  #组件分组信息矩阵
  stopifnot(length(control_sample) > 0, length(case_sample) > 0)
  group<-data.frame(
    sample=c(control_sample,case_sample),
    group=rep(c('Control','Case'),times=c(length(control_sample), length(case_sample)))
  )
  
  #因子化分组信息
  condition <- factor(c(group$group),#与列进行对应
                      levels = c("Control","Case"))#对照组在前，实验组在后
  #表达矩阵中列名对应的样本信息
  colData <- data.frame(row.names=colnames(countData), condition)#样本信息与分组信息匹配
  #差异分析
  dds <- DESeqDataSetFromMatrix(countData = countData, #表达矩阵
                                colData = colData, #样本信息
                                design = ~ condition)#分组信息
  #标准化
  # dds1 <- DESeq(dds, 
  #               fitType = 'mean', #使用均值作为拟合模型 所有基因共用一个离散度，只有在 parametric/local 都拟合失败时才当兜底用。这里等于放弃了 DESeq2 最核心的离散度收缩，会显著改变 p 值和 DEG 数量。
  #               minReplicatesForReplace = 3
  #               )
  # 使用默认参数
  dds1 <- DESeq(dds)
  #将结果用result()函数来获取
  res <- results(dds1)
  #res格式转化：用data.frame转化为表格形式
  res1 <- data.frame(res, stringsAsFactors = FALSE, check.names = FALSE)
  
  # 选定列名
  p_col <- ifelse(P_Type == 'Raw', 'pvalue', 'padj')
  # 排序并去除NA
  res1 <- res1[order(res1[[p_col]], res1$log2FoldChange, decreasing = c(FALSE, TRUE)), ]
  res1 <- res1[!is.na(res1[[p_col]]), ]
  # --- 向量化判断变化  ---
  # 先将所有基因默认标记为 'Stable'
  res1$Change <- 'Stable'
  # 批量找出满足上调条件的行，直接赋值 'Up'
  res1$Change[res1[[p_col]] < PValue_cutoff & res1$log2FoldChange > logFC_cutoff] <- 'Up'
  # 批量找出满足下调条件的行，直接赋值 'Down'
  res1$Change[res1[[p_col]] < PValue_cutoff & res1$log2FoldChange < -logFC_cutoff] <- 'Down'
  
  # 提示不同方向的基因数量
  message(table(res1$Change) %>% as.data.frame())
  
  # 如果满足条件（< PValue_cutoff），赋值为 'Sig'，否则赋值为 'Stable'
  res1$Sig <- ifelse(res1[[p_col]] < PValue_cutoff, 'Sig', 'Stable')
  
  if(P_Type=='Raw'){res1$pSelected<-res1$pvalue}else{res1$pSelected<-res1$padj}
  
  # 去除 Ensembl ID 的版本号（点号之后的部分）
  ensembl_ids <- gsub("\\..*", "", rownames(res1))
  # 使用 bitr 转换
  id_map <- bitr(ensembl_ids, 
                 fromType = "ENSEMBL", 
                 toType = "SYMBOL", 
                 OrgDb = org.Hs.eg.db, 
                 drop = FALSE)   # 保留无法映射的，方便查找
  # 将 Symbol 对应到 res1
  res1$SYMBOL <- id_map$SYMBOL[match(ensembl_ids, id_map$ENSEMBL)]
  # 若某些基因无对应 Symbol，可用原 Ensembl ID 填充，避免标签缺失
  res1$LABEL <- ifelse(is.na(res1$SYMBOL) | res1$SYMBOL == "", 
                       rownames(res1), 
                       res1$SYMBOL)
  
  write.csv(res1,'1.DESeq2_res1.csv',row.names = T)
  
  #03.火山图----------------------------------------------------------------------
  sig_diff<-res1[which(!res1$Change=='Stable'),]
  #挑选变化倍数前10
  dat_rep <- rbind(head(sig_diff[order(sig_diff$log2FoldChange,decreasing = T),],10),
                   head(sig_diff[order(sig_diff$log2FoldChange,decreasing = F),],10))
  
  #绘图
  volcano_plot <- ggplot(data = res1,aes(x = log2FoldChange,y = -log10(pSelected),color =Change)) +
    scale_color_manual(values = c("blue", "darkgray","darkorange")) +
    scale_x_continuous(breaks = seq(-5,5,1)
                       # limits = c(-7,7)
                       ) +
    scale_y_continuous(trans = "log1p",
                       # limits = c(0,10),
                       breaks=c(0,1,5,10,30)) +
    geom_point(size = 1.2, alpha = 0.4, na.rm=T) +
    theme_bw(base_size = 12, base_family = "Times") +
    geom_vline(xintercept = c(-logFC_cutoff,logFC_cutoff), lty = 4, col = "darkgray", lwd = 0.6)+
    geom_hline(yintercept = -log10(PValue_cutoff), lty = 4, col = "darkgray", lwd = 0.6)+
    theme(legend.position = "right",
          panel.grid = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(face="bold",color="black",family = "Times",size=13),
          plot.title = element_text(face = 'bold', hjust = 0.5),
          axis.text.x = element_text(face = "bold",color = "black",size = 15),
          axis.text.y = element_text(face = "bold",color = "black",size = 15),
          axis.title.x = element_text(face = "bold",color = "black",size = 15),
          axis.title.y = element_text(face = "bold",color = "black",size = 15)) +
    geom_label_repel(data = dat_rep, aes(label = rownames(dat_rep)),
                     max.overlaps = 20, size = 4,
                     box.padding = unit(0.5, "lines"),
                     min.segment.length = 0,
                     point.padding = unit(0.8, "lines"), segment.color = "black", show.legend = FALSE )+
    labs(x = "log2(Fold Change)",
         y = ifelse(P_Type=='Raw','-log10(P.Value)','-log10(P.Adjust)'),
         title = paste0(case_condition,' vs. ',control_condition))
  #输出文件
  export::graph2png(volcano_plot,
                    file='./2.DEGs_volcano.png',
                    width = 8.78, height = 7.43,dpi=600)
  export::graph2pdf(volcano_plot,
                    file='./2.DEGs_volcano.pdf',
                    width = 8.78, height = 7.43)
  
  
  #04.密度热图--------------------------------------------------------------------
  #前十FC的上下调差异基因
  top10_gene_down <- rownames(sig_diff %>% 
                                arrange(log2FoldChange) %>% 
                                head(10))
  top10_gene_up <- rownames(sig_diff %>% 
                              arrange(desc(log2FoldChange)) %>% 
                              head(10))
  top_gene <- c(top10_gene_down,top10_gene_up)
  #分组信息
  #vst
  vsd <- assay(vst(dds1, blind = FALSE))
  rt  <- vsd[top_gene, group$sample]
  group<-group[order(group$group),]
  x <- rt
  mat <- t(scale(t(x)))#归一化
  df1 <- as.data.frame(mat)
  mat[mat < (-2)] <- (-2)
  mat[mat > 2] <- 2
  identical(group$sample, colnames(mat))
  mat <- mat[, group$sample]
  identical(group$sample, colnames(mat))
  #绘图
  ppp <- densityHeatmap(mat ,title = "Distribution as heatmap", ylab = " ",
                        height = unit(3, "cm")) %v%
    HeatmapAnnotation(Group = group$group, col = list(Group = c("Case" = "#B72230",
                                                                "Control" = "#104680"))) %v%
    Heatmap(mat,
            row_names_gp = gpar(fontsize = 7),
            show_column_names = F,
            show_row_names = T,
            ###show_colnames = FALSE,
            name = "expression",
            ###cluster_cols = F,
            cluster_rows = F,
            height = unit(6, "cm"),
            #cluster_columns = FALSE,
            ###cluster_rows = FALSE,
            col = colorRampPalette(c("#0A878D", "white","#D80305"))(100))
  ppp
  #输出文件
  export::graph2png(ppp, 
                    file="./3.DEGs_deg_top_heatmap.png",
                    width=6.51,height=5.4,dpi=600)
  export::graph2pdf(ppp, 
                    file="./3.DEGs_deg_top_heatmap.pdf",
                    width=6.51,height=5.4)
  
  #05.Symbol版本-------------------------------------------------------------------
  # ---  带 Symbol 标签的火山图 ---
  # 沿用原来的 sig_diff 和 dat_rep 逻辑，但用 LABEL 来标记
  sig_diff_sym <- res1[!res1$Change == 'Stable', ]
  dat_rep_sym <- rbind(
    head(sig_diff_sym[order(sig_diff_sym$log2FoldChange, decreasing = TRUE), ], 10),
    head(sig_diff_sym[order(sig_diff_sym$log2FoldChange, decreasing = FALSE), ], 10)
  )
  
  # 绘图
  volcano_plot_symbol <- ggplot(data = res1, 
                                aes(x = log2FoldChange, 
                                    y = -log10(pSelected), 
                                    color = Change)) +
    scale_color_manual(values = c("blue", "darkgray", "darkorange")) +
    scale_x_continuous(breaks = seq(-5, 5, 1) 
                       # limits = c(-7, 7)
                       ) +
    scale_y_continuous(trans = "log1p", 
                       # limits = c(0, 10), 
                       breaks = c(0, 1, 3, 10, 30)) +
    geom_point(size = 1.2, alpha = 0.4, na.rm = TRUE) +
    theme_bw(base_size = 12, base_family = "Times") +
    geom_vline(xintercept = c(-logFC_cutoff, logFC_cutoff), 
               lty = 4, col = "darkgray", lwd = 0.6) +
    geom_hline(yintercept = -log10(PValue_cutoff), 
               lty = 4, col = "darkgray", lwd = 0.6) +
    theme(legend.position = "right",
          panel.grid = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(face = "bold", color = "black", 
                                     family = "Times", size = 13),
          plot.title = element_text(face = 'bold', hjust = 0.5),
          axis.text.x = element_text(face = "bold", color = "black", size = 15),
          axis.text.y = element_text(face = "bold", color = "black", size = 15),
          axis.title.x = element_text(face = "bold", color = "black", size = 15),
          axis.title.y = element_text(face = "bold", color = "black", size = 15)) +
    geom_label_repel(data = dat_rep_sym, 
                     aes(label = LABEL),   # 此处换为 Symbol 标签
                     max.overlaps = 20, size = 4,
                     box.padding = unit(0.5, "lines"),
                     min.segment.length = 0,
                     point.padding = unit(0.8, "lines"), 
                     segment.color = "black", show.legend = FALSE) +
    labs(x = "log2(Fold Change)",
         y = ifelse(P_Type == 'Raw', '-log10(P.Value)', '-log10(P.Adjust)'),
         title = paste0(case_condition, ' vs. ', control_condition, ' (Symbol label)'))
  
  # 保存
  export::graph2png(volcano_plot_symbol,
                    file = './4.DEGs_volcano_symbol.png',
                    width = 8.78, height = 7.43, dpi = 600)
  export::graph2pdf(volcano_plot_symbol,
                    file = './4.DEGs_volcano_symbol.pdf',
                    width = 8.78, height = 7.43)
  
  # ---  带 Symbol 标签的热图 ---
  # 获取 top10 上下调基因对应的 Symbol
  top10_gene_down_sym <- rownames(sig_diff_sym %>% 
                                    arrange(log2FoldChange) %>% 
                                    head(10))
  top10_gene_up_sym <- rownames(sig_diff_sym %>% 
                                  arrange(desc(log2FoldChange)) %>% 
                                  head(10))
  top_gene_sym <- c(top10_gene_down_sym, top10_gene_up_sym)
  
  # 提取这些基因的表达数据，并用 Symbol 作为行名
  # 改用 vst（与前一张热图一致，A2 的修复）
  rt_sym <- vsd[top_gene_sym, group$sample, drop = FALSE]
  
  # 行名换成 Symbol；重名时自动加 .1 .2 后缀
  lab <- as.character(res1[top_gene_sym, "LABEL"])
  lab[is.na(lab) | lab == ""] <- top_gene_sym[is.na(lab) | lab == ""]
  rownames(rt_sym) <- make.unique(lab)
  
  # 归一化与绘图
  mat_sym <- t(scale(t(rt_sym)))
  mat_sym[mat_sym < -2] <- -2
  mat_sym[mat_sym > 2] <- 2
  # 确保列名顺序与 group 一致
  mat_sym <- mat_sym[, group$sample]
  
  ppp_symbol <- densityHeatmap(mat_sym, 
                               title = "Distribution as heatmap (Symbol)", 
                               ylab = " ",
                               height = unit(3, "cm")) %v%
    HeatmapAnnotation(Group = group$group, 
                      col = list(Group = c("Case" = "#B72230",
                                           "Control" = "#104680"))) %v%
    Heatmap(mat_sym,
            row_names_gp = gpar(fontsize = 7),
            show_column_names = FALSE,
            show_row_names = TRUE,
            name = "expression",
            cluster_rows = FALSE,
            height = unit(6, "cm"),
            col = colorRampPalette(c("#0A878D", "white", "#D80305"))(100))
  
  # 保存
  export::graph2png(ppp_symbol, 
                    file = "./5.DEGs_deg_top_heatmap_symbol.png",
                    width = 6.51, height = 5.4, dpi = 600)
  export::graph2pdf(ppp_symbol, 
                    file = "./5.DEGs_deg_top_heatmap_symbol.pdf",
                    width = 6.51, height = 5.4)
}

# 读取数据
counts<-readRDS('../00_PreProcess/counts.RDS')
group<-readRDS('../00_PreProcess/group.RDS')

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
  #对应的Condition
  case_condition<-group[c(((i-1)*6+1):(i*6)),] %>%
    dplyr::filter(Group=='Case') %>%
    dplyr::pull('DETAILS') %>% as.character() %>% unique()
  control_condition<-group[c(((i-1)*6+1):(i*6)),] %>%
    dplyr::filter(Group=='Control') %>%
    dplyr::pull('DETAILS') %>% unique() %>% as.character()
  
  getDEGs(
    case_condition,
    control_condition,
    counts_input=counts,
    group_input=group,
    P_Type='Adjust',
    PValue_cutoff=0.05,
    logFC_cutoff=1
  )
  setwd('../')
}


# 差异基因的Venn图
{
  # 加载必要的 R 包
  library(tidyverse)
  library(ggVennDiagram)
  library(ggplot2)
  
  # 1. 自动获取所有子文件夹中的目标文件路径
  # recursive = TRUE 代表递归搜索子文件夹
  file_paths <- list.files(path = ".", 
                           pattern = "1\\.DESeq2_res1\\.csv$", 
                           recursive = TRUE, 
                           full.names = TRUE)
  
  # 2. 提取子文件夹的名称，用作 Venn 图的组名
  # dirname() 获取文件所在目录，basename() 提取该目录的最后一级名称
  group_names <- basename(dirname(file_paths))
  
  # 3. 批量读取文件并提取差异基因 (DEGs)
  gene_list <- lapply(file_paths, function(file) {
    # 读取 csv 文件
    df <- read.csv(file, stringsAsFactors = FALSE)
    
    # 假设你需要在这里进行差异基因的筛选 (比如 padj < 0.05 且 |log2FC| > 1)
    # 如果你的 CSV 已经是过滤好的纯差异基因表，可以把 filter 这一行注释掉
    df_sig <- df %>%
      filter(padj < 0.05 & abs(log2FoldChange) > 1)
    
    # 假设基因名在第一列，提取第一列的基因名并去重
    # 如果你的基因名在特定列 (如 'Geneid')，请把 df_sig[[1]] 改为 df_sig$Geneid
    genes <- unique(as.character(df_sig[[1]]))
    
    return(genes)
  })
  
  # 将子文件夹名赋予基因列表，作为集合名称
  names(gene_list) <- group_names
  
  # 4. 使用 ggVennDiagram 绘制韦恩图
  venn_plot <- ggVennDiagram(gene_list, 
                             label_alpha = 0, # 去除数字标签底部的半透明背景，更清爽
                             edge_size = 0.5) +
    # 自定义配色方案 (从白色过渡到红色)
    scale_fill_gradient(low = "#F4FAFE", high = "#4981BF", name = "Gene Count") +
    # 调整主题，隐去网格和坐标轴
    theme_void() +
    # 修改组名标签的字体大小和颜色
    theme(legend.position = "none",
          plot.title = element_text(face = 'bold', hjust=0.5)) +
    labs(title = "Venn Diagram of DEGs Across Groups")+
    scale_x_continuous(expand = expansion(mult = 0.4))
  
  # 显示图片
  print(venn_plot)
  
  # 5. 保存图片为高清 PDF 或 PNG
  ggsave("Venn_Diagram_DEGs.pdf", plot = venn_plot, width = 12, height = 9)
  ggsave("Venn_Diagram_DEGs.png", plot = venn_plot, width = 12, height = 9,dpi=600)
  
}



