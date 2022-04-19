library(readr)
library(rvest)
library(tidyverse)
library(dplyr)
library(purrr)
library(janitor)
library(tidyr)
library(ggplot2)
library(readr)
library(broom)
library(viridis)
library(rgdal)
library(gganimate)
library(maptools) 
library(gapminder)

library(maps)
library(ggthemes)

library(maps)
library(GEOmap)


setwd("C:/Users/Lenovo/Google Drive/ai360/Mapa_CDMX")
rm(list=ls())
d <- read.csv("Avaluos2013.csv")
e <- read.csv("CP_estados.csv")

j <- left_join(d,e)
write.csv(j, file = "e2013.csv", row.names = FALSE)


names(d)
