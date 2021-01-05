#package pheatmap 
#https://cran.r-project.org/web/packages/pheatmap/pheatmap.pdf
library(pheatmap)

#max value for color values
paletteLength <- 50

#read data form tab separated file input_1.tab
data1 <- read.table("input_1.tab",sep="\t", header=TRUE,row.names="gene_id")
my_sample_col <- data.frame(groups = rep(c("-", "k","+"), c(4,4,4)))
row.names(my_sample_col) <- colnames(data1)
my_colour = list(groups = c("+" = "black", "k" = "#F0E442", "-" = "#56B4E9")
)

#a sequence of numbers that covers the range of values in mat and is one elementlonger than color vector.  Used for mapping values to colors.
#Useful, if needed to map certain values to certain colors, to certain values.
#If value is NA then the breaks are calculated automatically. When breaks do not cover the range of values, then any value larger than max(breaks) will have the largest color and any value lower
#than min(breaks) will get the lowest color
myBreaks1 <- c(seq(min(data1), 0, length.out=ceiling(paletteLength/2) + 1), 
              seq(max(data1)/paletteLength, max(data1), length.out=floor(paletteLength/2)))

#output a .png file
png('rplot1_colorblind.png',width=2000, height=2000,res=300)

#colorRampPalette(c("#D55E00", "white", "#009E73"))(50) = minimum, middle and maximum color in range 0-50
#clustering_method="complete" = https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/hclust

pheatmap(data1,color = colorRampPalette(c("#D55E00", "white", "#009E73"))(50),breaks=myBreaks1,clustering_method="complete",annotation_colors = my_colour,annotation_col = my_sample_col,cluster_rows=TRUE,cluster_columns=TRUE,show_rownames = FALSE,angle_col=45)

#close output file
dev.off()
