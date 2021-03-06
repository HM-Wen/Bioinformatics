library('gplots')

CLUSTER_NUM=5


rawdata=read.table('CHANGE.tsv',header=T,row.names=1)
data=as.matrix(rawdata)#-log(rawdata,10))
rownames(data)=rownames(rawdata)
colnames(data)=colnames(rawdata)

#data[which(data>3)]=3
#data[which(data <=-3)]= -3

DIST=dist(data)
HCLUST=hclust(DIST)
N=cutree(HCLUST,k=CLUSTER_NUM)
CCC=rainbow(CLUSTER_NUM)
COL=rep('red',length(data[,1]))
i=1
while(i<=CLUSTER_NUM){
COL[which(N==i)]=CCC[i]
i=i+1
}


pdf('image/HEATMAP.pdf',width=10,height=20)
hmr=heatmap.2(data,scale=c("none"),dendrogram='row',Colv=F,trace='none',col=colorRampPalette(c('blue','white','red')),RowSideColors=COL,margins=c(20,20))
dev.off()

pdf('image/COLORMAP.pdf',width=25,height=50)
i=1
while(i<=CLUSTER_NUM){
TMP_COL=rep('grey',length(data[,1]))
TMP_COL[which(N==i)]=CCC[i]
heatmap.2(data,scale=c("none"),dendrogram='row',Colv=F,trace='none',col=colorRampPalette(c('grey95','indianred')),RowSideColors=TMP_COL,main=as.character(i) ,margins=c(20,20))
write.table(data[ rownames(data) %in% rownames(data)[which(N==i)],],paste0('CLUSTER/',as.character(i),'.txt'),quote=F,sep='\t')
print(i)
i=i+1
}
dev.off()



