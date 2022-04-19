
library(tidyverse)
library(gganimate)


setwd("C:/Users/Usuario/Google Drive/ai360/Mapa_CDMX")
rm(list=ls())
cdmx <- read_csv("nCDMX.csv")

cdmx_formatted <- cdmx %>%
  group_by(Fecha) %>%
  # The * 1 makes it possible to have non-integer ranks while sliding
  mutate(rank = rank(-count),
         Value_rel = count/count[rank==1],
         Value_lbl = count) %>%
  group_by(Municipio) %>% 
  filter(rank <=10) %>%
  ungroup()

#write.csv(cdmx_formatted, file = "DatosFormateados1.csv", row.names = FALSE)


geom.text.size = 10
staticplot = ggplot(cdmx_formatted, aes(rank, group = Municipio, 
                                       fill = as.factor(Municipio), color = as.factor(Municipio))) +
  geom_tile(aes(y = count/2,
                height = count,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(Municipio, " ")), vjust = 0.2, hjust = 1,size=geom.text.size) +
  geom_text(aes(y=count,label = Value_lbl, hjust=0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm"))



anim = staticplot + transition_states(Fecha, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'Avalúos por mes : {closest_state}',  
       subtitle  =  "Top 10 Alcaldías",
       caption  = "Avalúos | Data Source: ai360")

an <- animate(anim, fps=3)
an

animate(anim, 200, fps = 1,  width = 1200, height = 1000, 
        renderer = gifski_renderer("gganim.gif")) 
