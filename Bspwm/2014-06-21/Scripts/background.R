#!/usr/bin/Rscript

library(ggplot2)
library(plyr)

prog_june <- read.csv("~/.config/bspwm/Data/prog-june.csv")

gg_june <- ggplot(prog_june, aes(x=Date, y=Number, fill=Pages, order=desc(Pages))) + geom_hline(yintercept = c(0, 20, 40), colour="#585858", size=0.2) + geom_bar(stat="identity", width=.4) + scale_fill_manual(values=c("#f7d900","#646464")) + theme(title=element_text(size=9, family="DejaVu Sans", color="#afd700", hjust=0.1, vjust=1.4), text=element_text(size=12, family="DejaVu Sans"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.x = element_blank(), axis.text.x = element_blank(),  axis.title.y = element_blank(), axis.line = element_blank(), panel.border = element_blank(), axis.ticks = element_blank(), plot.background = element_rect(fill = "transparent",colour = NA), panel.background = element_rect(fill = "transparent",colour = NA), legend.position = 'none') + ggtitle("Giugno")

png('~/.config/bspwm/Background/stats-june.png',width=700,height=150,units="px",bg = "transparent")
print(gg_june)
dev.off()
