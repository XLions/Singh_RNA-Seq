#bluebear的X11选项加载
options(bitmapType='cairo')

setwd('/rds/projects/g/gendood-preclinomics/260306_Singh-RNAseq/Downstream/')

rm(list = ls());gc()
folder<-'00_PreProcess';if(!dir.exists(folder)){dir.create(folder)};setwd(folder)

library(tidyverse)

#1.处理表达矩阵
{
  #读取featureCounts给出的表格
  raw_df<-read.table('../../Matrix_featureCounts/all_samples_counts.txt',
                     comment.char = '#',header = T) %>%
    dplyr::select(-c("Chr","Start","End","Strand"))
  
  #重新命名列
  new_colnames<-colnames(raw_df) %>%
    str_remove_all('X.rds.projects.g.gendood.preclinomics.260306_Singh.RNAseq.BAM_Samtools.') %>%
    str_remove_all('_sorted.bam') %>%
    str_remove(".*_")
  colnames(raw_df)<-new_colnames
  
  #转换成FPKM
  {
    # 1. 提取纯 Counts 矩阵 (即排除第1列 Geneid 和第2列 Length)
    # 从第3列(S1)开始，一直到最后一列
    counts_mat <- raw_df[, 3:ncol(raw_df)]
    
    # 2. 提取基因长度向量
    gene_lengths <- raw_df$Length
    
    # 3. 计算每个样本的总 mapped reads 数 (即每列的总和)
    total_reads <- colSums(counts_mat)
    
    # 4. 计算 FPKM
    # 步骤 A: 测序深度标准化 (Counts / Total_Reads * 10^6) -> 得到 RPM/CPM
    rpm <- sweep(counts_mat, MARGIN = 2, STATS = total_reads, FUN = "/") * 1e6
    
    # 步骤 B: 基因长度标准化 (RPM / Length * 10^3) -> 得到 FPKM
    fpkm_mat <- sweep(rpm, MARGIN = 1, STATS = gene_lengths, FUN = "/") * 1e3
    
    # 5. 将 Geneid 重新加回到 FPKM 矩阵中，生成最终的数据框
    fpkm_df <- data.frame(Geneid = raw_df$Geneid, fpkm_mat)
    
    # 6. 重命名列
    fpkm_df<- fpkm_df %>% column_to_rownames('Geneid')
    
    # 将结果保存为新的 CSV 或 TXT 文件
    write.csv(fpkm_df, file = "fpkm.csv", row.names = FALSE)
    saveRDS(fpkm_df,"fpkm.RDS")
  }
  
  #保存counts
  {
    # 重命名列
    raw_counts<- raw_df %>%
      dplyr::select(-c("Length")) %>% column_to_rownames('Geneid')
    
    # 将结果保存为新的 CSV 或 TXT 文件
    write.csv(raw_counts, file = "counts.csv", row.names = FALSE)
    saveRDS(raw_counts,"counts.RDS")
  }
}

#2.处理分组信息
{
  library(openxlsx)
  
  df<-read.xlsx('../../Data/RNA Seq Form.xlsx')
  
  df_clean <- df[1:24,] %>%
    # 第一步：把SAMPLE保存为新列
    mutate(`DETAILS` = Sample) %>%
    # 第二步：把 "SMAPLE ID" 列里的 "MTOP " 替换为 "S"
    # "MTOP\\s*" 意思是匹配 "MTOP" 以及它后面的所有空格，这样 "MTOP 1" 会变成 "S1"
    mutate(`SMAPLE ID` = str_replace(`SMAPLE.ID`, "MTOP\\s*", "S")) %>%
    # 第三步：拆分 "Sample" 列
    # 正则表达式 "^(BT \\d+)\\s+(.*)$" 逻辑：
    # 1. (BT \\d+) 捕获 "BT" 加空格加连续数字，放进 "Cell" 列
    # 2. \\s+ 匹配中间的分隔空格（忽略不计入新列）
    # 3. (.*) 捕获剩下的所有字符，放进 "Group" 列
    extract(Sample, into = c("Cell", "Treatment"), regex = "^(BT \\d+)\\s+(.*)$") %>%
    # 第四步：重命名样本列以方便之后分析
    dplyr::rename('Sample'='SMAPLE ID')
  df_clean$Group<-rep(c(rep(c('Control','Case'),each=3)),4)
  
  df_ss<-data.frame(
    `SMAPLE.ID`=df$`SMAPLE.ID`[25:30],
    Cell=NA,
    Treatment=df$Sample[25:30],
    DETAILS=df$Sample[25:30],
    Sample=paste0('S',c(25:30)),
    Group=rep(c('Case','Control'),each=3)
  )
  df_clean<-rbind(df_clean,df_ss)
  
  #空格用下划线替代
  df_clean$DETAILS<-str_replace_all(df_clean$DETAILS,' ','_')
  
  df_clean$CompareGroup<-paste0(
    'Compare',rep(c(1:5),each=6)
  )
  
  # 查看最终结果
  print(df_clean)
  
  # 保存
  write.csv(df_clean,'group.csv',row.names = F)
  saveRDS(df_clean,'group.RDS')
}

#3.PCA
{
  library(ggrepel)
  # 所有样本
  {
    # 0. 读取数据
    fpkm_mat<-readRDS('./fpkm.RDS')
    group_df<-readRDS('./group.RDS') %>% dplyr::select('Sample','DETAILS','CompareGroup')
    
    # 1. 数据预处理：log2 转换并过滤方差为0的基因
    # 加上 1 是为了防止 log2(0) 产生 -Inf 
    fpkm_log <- log2(fpkm_mat + 1)
    
    # 过滤掉方差为 0 的行（即在所有样本中表达量完全一样的基因）
    # 这对 prcomp() 的 scale. = TRUE 参数是必须的
    fpkm_filtered <- fpkm_log[apply(fpkm_log, 1, var) > 0, ]
    
    # 2. 运行 PCA
    # prcomp() 要求行是样本，列是基因，所以需要使用 t() 进行转置
    # scale. = TRUE 对基因表达量进行标准化，消除极高表达基因的绝对主导作用
    pca_res <- prcomp(t(fpkm_filtered), scale. = TRUE)
    
    # 3. 提取 PCA 坐标并与分组信息合并
    # 提取前两个主成分 (PC1 和 PC2)
    pca_df <- as.data.frame(pca_res$x[, 1:2]) 
    pca_df$Sample <- rownames(pca_df) # 将行名转为 Sample 列
    
    # 将 PCA 结果与你的分组数据框(group_df)合并
    # group_df 包含两列：Sample 和 DETAILS
    pca_data <- merge(pca_df, group_df, by = "Sample")
    
    # 4. 计算 PC1 和 PC2 的方差解释比例 (用于坐标轴标签)
    pca_var <- pca_res$sdev^2
    var_explained <- pca_var / sum(pca_var) * 100
    pc1_label <- paste0("PC1 (", round(var_explained[1], 1), "%)")
    pc2_label <- paste0("PC2 (", round(var_explained[2], 1), "%)")
    
    # 使用 ggplot2 进行可视化并添加标签
    pca_plot1 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = DETAILS)) +
      # 1. 画散点
      geom_point(size = 3.5, alpha = 0.9) +
      
      # 2. 自定义颜色
      scale_color_manual(
        values = c("#A6CEE3" ,"#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", 
                   "#E31A1C", "#FDBF6F", "#FF7F00", "#CAB2D6", "#6A3D9A", 
                   "#FFFF99", "#984EA3", "#FFFF33", "#A65628", "#F781BF", 
                   "#999999", "#8DD3C7", "#FCCDE5", "#A6D854", "#FFD92F","#66C2A5"))+
      
      # 3. 添加样本名标签
      geom_text_repel(
        aes(label = Sample), 
        size = 3.5,              # 字体大小
        nudge_y = 0.5,           # 整体向上方微调偏移 (相当于在散点上方)
        max.overlaps = 50,       # 允许的最大重叠尝试次数，防止点太多时部分标签不显示
        show.legend = FALSE      # 这一步很重要，防止样本名混入右侧的图例中
      ) +
      
      # 4. 设置坐标轴标签和主标题
      labs(title = "PCA of RNA-seq (FPKM)", 
           x = pc1_label, 
           y = pc2_label) +
      
      # 5. 主题和细节美化
      theme_bw() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14), 
        axis.title = element_text(face = "bold", size = 12),              
        axis.text = element_text(size = 10),                              
        legend.title = element_blank(),                                   
        legend.position = "right",                                        
        panel.grid.major = element_line(color = "gray90"),                
        panel.grid.minor = element_blank()                                
      )
    pca_plot2 <- ggplot(pca_data, aes(x = PC1, y = PC2, color = CompareGroup)) +
      # 1. 画散点
      geom_point(size = 3.5, alpha = 0.9) +
      
      # 2. 自定义颜色
      scale_color_manual(
        values = c("#A6CEE3" ,"#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", 
                   "#E31A1C", "#FDBF6F", "#FF7F00", "#CAB2D6", "#6A3D9A", 
                   "#FFFF99", "#984EA3", "#FFFF33", "#A65628", "#F781BF", 
                   "#999999", "#8DD3C7", "#FCCDE5", "#A6D854", "#FFD92F","#66C2A5"))+
      
      # 3. 添加样本名标签
      geom_text_repel(
        aes(label = Sample), 
        size = 3.5,              # 字体大小
        nudge_y = 0.5,           # 整体向上方微调偏移 (相当于在散点上方)
        max.overlaps = 50,       # 允许的最大重叠尝试次数，防止点太多时部分标签不显示
        show.legend = FALSE      # 这一步很重要，防止样本名混入右侧的图例中
      ) +
      
      # 4. 设置坐标轴标签和主标题
      labs(title = "PCA of RNA-seq (FPKM)", 
           x = pc1_label, 
           y = pc2_label) +
      
      # 5. 主题和细节美化
      theme_bw() +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14), 
        axis.title = element_text(face = "bold", size = 12),              
        axis.text = element_text(size = 10),                              
        legend.title = element_blank(),                                   
        legend.position = "right",                                        
        panel.grid.major = element_line(color = "gray90"),                
        panel.grid.minor = element_blank()                                
      )
    
    # 保存图片为高清 PDF 或 PNG
    ggsave("1.PCA_plot_AllSamples_bySample.pdf", plot = pca_plot1, width = 6, height = 5)
    ggsave("1.PCA_plot_AllSamples_bySample.png", plot = pca_plot1, width = 6, height = 5, dpi = 600)
    
    # 保存图片为高清 PDF 或 PNG
    ggsave("2.PCA_plot_AllSamples_byCompare.pdf", plot = pca_plot2, width = 6, height = 5)
    ggsave("2.PCA_plot_AllSamples_byCompare.png", plot = pca_plot2, width = 6, height = 5, dpi = 600)

  }
}

#4.比对率
{
  library(scales) # 用于将 X 轴转换为百分比格式
  
  # 1. 读取数据
  # 假设你把上面那段数据保存为了 "featureCounts.summary.txt"
  # check.names = FALSE 很重要，防止 R 把你的绝对路径列名自动替换成带点的乱码
  df <- read.delim("../../Matrix_featureCounts/all_samples_counts.txt.summary", check.names = FALSE)
  
  # 2. 数据清洗与格式转换
  df_long <- df %>%
    # 将宽格式转为长格式，提取文件路径和对应的 reads 数
    pivot_longer(
      cols = -Status, 
      names_to = "File_Path", 
      values_to = "Count"
    ) %>%
    # 核心：使用 basename() 提取纯文件名 (丢弃 /rds/projects/... 等前缀)
    mutate(Sample = basename(File_Path)) %>%
    # 清理：过滤掉 Count 为 0 的分类（如 Chimera, Duplicate 等），让图例更清爽
    filter(Count > 0)
  
  # 3. 绘制 100% 堆叠条形图
  assignment_plot <- ggplot(df_long, aes(x = Count, y = Sample, fill = Status)) +
    # position = "fill" 会自动按样本计算各类别的百分比
    geom_bar(stat = "identity", position = "fill", color = "white", linewidth = 0.2) +
    
    # 将 X 轴设置为 0% - 100% 显示
    scale_x_continuous(labels = percent_format()) +
    
    # 使用内置的 Set2 色板，颜色区分度高且柔和 (你的数据实际只有4个非0类别)
    scale_fill_brewer(palette = "Set2") +
    
    # 设置标签
    labs(
      title = "Read Assignment Rate summary",
      x = "Percentage of Reads (%)",
      y = NULL, # 去掉 Y 轴标题（因为文件名已经很明确了）
      fill = "Mapping Status"
    ) +
    
    # 细节美化
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
      axis.text.y = element_text(size = 9, color = "black"), # 确保文件名清晰
      axis.text.x = element_text(size = 10, color = "black"),
      legend.position = "right",
      legend.title = element_text(face = "bold"),
      panel.grid.major.y = element_blank() # 去除横向网格线，让条形图更干净
    )
  
  # 显示图表
  print(assignment_plot)
  
  # 4. 保存
  ggsave("3.Assignment_Rate_Plot.pdf", plot = assignment_plot, width = 12, height = 8)
  ggsave("3.Assignment_Rate_Plot.png", plot = assignment_plot, width = 12, height = 8,dpi=600)
  
}