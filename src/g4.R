setwd('C:/Users/olgal/Desktop/project')
library(ggplot2)
library(dplyr)
library(tidyr)   # replace_na
library(tibble)  # column_to_rownames

#DATA_DIR <- '../data/'
#OUT_DIR <- '../images/

#NAME <- 'H3K36me3_HCT116.ENCFF108HPY.hg19'#2100
#NAME <- 'H3K36me3_HCT116.ENCFF506OSH.hg19' #1625
#NAME <- 'G4.hg19'
NAME <- 'H3K36me3_HCT116.intersect_with_G4'
OUT_DIR <- 'C:/Users/olgal/Desktop/project/Results/'


#Р“РРЎРўРћР“Р РђРњРњР« Р”Р›РРќ РЈР§РђРЎРўРљРћР’

bed_df <- read.delim(paste0('data/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

# hist(bed_df$len)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)


#РћР‘Р Р•Р—РљРђ Р”Р›РРќРќР«РҐ РЈР§РђРЎРўРљРћР’

bed_df <- read.delim(paste0('data/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 10000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.pdf'), path = OUT_DIR)

bed_df %>%
  select(-len) %>%
  write.table(file='data/H3K4me3_A549.ENCFF832EOL.hg19.filtered.bed',
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)

