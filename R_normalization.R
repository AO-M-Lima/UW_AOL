setwd("/Users/aolim/Desktop/Andressa-2022/aluno/makyala") ##change the directory
###

##normalization data using  TMM (edger/limma)
##library
library(limma) #biocondutor
library(edgeR) #biocondutor 

#data
A2=read.delim("A2_htseq.txt", header=T, na.strings = "NA")
head(A2)
A2[1:2,1:2]
B2=read.delim("B2_htseq.txt", header=T, na.strings = "NA")
head(B2)
B2[1:2,1:2]

##merge file by gene_id

#put all data frames into list
df_list = list(A2,B2)
#merge all data frames in list
df1 = data.frame(
  Reduce(function(x, y)
    merge(x, y, all=TRUE, by="Gene_id"), df_list)) ##works but put all in the same list
##

##save the gene symbol

head(df1)
gene_symbol = df1[,c("Gene_id", "Gene_symbol.x")]
colnames(gene_symbol)[2] = "Gene_symbol" 
head(gene_symbol)
##

#matrix  data
count = df1[,c("Gene_id", "counts.x", "counts.y")]
head(count)
colnames(count) = c("Gene_id","A2", "B2")
head(count)
##

##transform first column to rownames 
row.names(count) = count[,1] 
head(count)
##
count = count[,-1]          
str(count)
count[1:2,1:2]
head(count)
dim(count)

#remove genes non-expressed 
## total counts per gene
Totalcounts = rowSums(count)
## genes with zero count?
table(Totalcounts==0)
## filter genes with 0 counts
rm = rowMeans(count)==0
mRNA.filter = count[!rm,]
dim(mRNA.filter)
mRNA.filter[1:2,1:2]
##


##raw data
#box plot
tiff(filename = "boxplot-raw.tiff", res=300,
     width = 4500, height = 3500, pointsize = 10,
)
par(mar = c(8,4,4,4))
par (cex=0.8)
par(las=3) #colocar o texto paralelo ao eixo

boxplot(log(mRNA.filter+1, base=2) , main="Expression Counts level",
        ylab="Log2_Expressionlevel", col =c("grey") )
dev.off()
##

##normalization using TMM

d = DGEList(counts=mRNA.filter)
TMM = calcNormFactors(d, method = "TMM")
head(TMM$samples)
#get the normalized counts:
cpm = cpm(TMM, log=FALSE)

head(cpm) ##norm
head(mRNA.filter) ##data raw
##
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##normalized data data
#box plot
tiff(filename = "boxplot-norm.tiff", res=300,
     width = 4500, height = 3500, pointsize = 10,
)
par(mar = c(8,4,4,4))
par (cex=0.8)
par(las=3) #colocar o texto paralelo ao eixo

boxplot(log(cpm+1, base=2) , main="Expression Counts level",
        ylab="Log2_Expressionlevel", col =c("lightblue") )
dev.off()
##

##save data

write.table(cpm, file= "norm-data.txt", row.names = T, sep = "\t",
            quote = F)

write.table(gene_symbol, file= "gene-symbol.txt", row.names = F, sep = "\t",
            quote = F)


