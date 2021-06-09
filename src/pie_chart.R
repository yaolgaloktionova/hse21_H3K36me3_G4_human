###
BiocManager::install(c('TxDb.Hsapiens.UCSC.hg19.knownGene', 'ChIPseeker', 'clusterProfiler'))
BiocManager::install(c('TxDb.Hsapiens.UCSC.hg19.knownGene', 'ChIPseeker', 'clusterProfiler'))
BiocManager::install('TxDb.Hsapiens.UCSC.hg19.knownGene')
BiocManager::install('clusterProfiler')
BiocManager::install('DO.db')
BiocManager::install('org.Hs.eg.db')

OUT_DIR <- 'C:/Users/olgal/Desktop/project/Results/'
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
#library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(clusterProfiler)
#BiocManager::install('ChIPseeker')

###

#NAME <- 'H3K4me3_A549.intersect_with_DeepZ'
#NAME <- 'DeepZ'
#NAME <- 'H3K36me3_HCT116.ENCFF506OSH.hg19.filtered'
#NAME <- 'H3K36me3_HCT116.ENCFF108HPY.hg19.filtered'
#NAME <- 'G4.hg19'
NAME <- 'H3K36me3_HCT116.intersect_with_G4'
DATA_DIR <- 'C:/Users/olgal/Desktop/project/data/'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

#pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

# peak <- readPeakFile(BED_FN)
# pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
# covplot(peak, weightCol="V5")
# dev.off()
# 