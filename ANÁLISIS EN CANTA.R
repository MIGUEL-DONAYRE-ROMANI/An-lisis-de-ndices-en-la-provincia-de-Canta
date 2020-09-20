rm(list = ls())
library(sp)
library(sf)
library(raster)
library(maptools)
library(tidyverse)
library(rgdal)
library(stars)
library(rgeos)
library(gtools)

getwd()
setwd("C:/Users/mdona/OneDrive/Escritorio/shape")

#Canta 2014-------------------------------------------------------------------------------------

#precipitacion_2014

pp_1_14 <- raster("pp/wc2.1_2.5m_prec_2014-01.tif")
pp_2_14 <- raster("pp/wc2.1_2.5m_prec_2014-02.tif")
pp_3_14 <- raster("pp/wc2.1_2.5m_prec_2014-03.tif")
pp_4_14 <- raster("pp/wc2.1_2.5m_prec_2014-04.tif")
pp_5_14 <- raster("pp/wc2.1_2.5m_prec_2014-05.tif")
pp_6_14 <- raster("pp/wc2.1_2.5m_prec_2014-06.tif")
pp_7_14 <- raster("pp/wc2.1_2.5m_prec_2014-07.tif")
pp_8_14 <- raster("pp/wc2.1_2.5m_prec_2014-08.tif")
pp_9_14 <- raster("pp/wc2.1_2.5m_prec_2014-09.tif")
pp_10_14 <- raster("pp/wc2.1_2.5m_prec_2014-10.tif")
pp_11_14 <- raster("pp/wc2.1_2.5m_prec_2014-11.tif")
pp_12_14 <- raster("pp/wc2.1_2.5m_prec_2014-12.tif")

precip_tot_2014 <- pp_1_14 + pp_2_14 + pp_3_14 + pp_4_14 + pp_5_14 +
  pp_6_14 + pp_7_14 + pp_8_14 +
  pp_9_14 + pp_10_14 + pp_11_14 + pp_12_14
plot(precip_tot_2014, main = "Precipitación total del año 2014")

#Temperatura media anual del 2014

#Temperatura máxima 2014

tmax_1_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-01.tif")
tmax_2_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-02.tif")
tmax_3_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-03.tif")
tmax_4_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-04.tif")
tmax_5_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-05.tif")
tmax_6_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-06.tif")
tmax_7_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-07.tif")
tmax_8_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-08.tif")
tmax_9_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-09.tif")
tmax_10_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-10.tif")
tmax_11_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-11.tif")
tmax_12_14 <- raster("tmax/wc2.1_2.5m_tmax_2014-12.tif")

tmax_2014 <- (tmax_1_14 + tmax_2_14 + tmax_3_14 + tmax_4_14 + tmax_5_14 +
                tmax_6_14 + tmax_7_14 + tmax_8_14 + tmax_9_14 + tmax_10_14 +
                tmax_11_14 + tmax_12_14) / 12
plot(tmax_2014, 
     main = "Temperatura máxima media anual del año 2014")

#Temperatura mínima 2014

tmin_1_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-01.tif")
tmin_2_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-02.tif")
tmin_3_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-03.tif")
tmin_4_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-04.tif")
tmin_5_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-05.tif")
tmin_6_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-06.tif")
tmin_7_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-07.tif")
tmin_8_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-08.tif")
tmin_9_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-09.tif")
tmin_10_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-10.tif")
tmin_11_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-11.tif")
tmin_12_14 <- raster("tmin/wc2.1_2.5m_tmin_2014-12.tif")

tmin_2014 <- (tmin_1_14 + tmin_2_14 + tmin_3_14 + tmin_4_14 + tmin_5_14 +
                tmin_6_14 + tmin_7_14 + tmin_8_14 + tmin_9_14 + tmin_10_14 +
                tmin_11_14 + tmin_12_14) / 12
plot(tmin_2014, 
     main = "Temperatura mínima media anual del 2014")

#Temperatura media anual

tm_prom_2014 <- (tmax_2014 + tmin_2014) / 2
plot(tm_prom_2014, main = "Temperatura media (°C) del año 2014")

##cargar shape Canta

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)

#Cortar para Lima 2014-------------------------------------------------------------------------

crs(canta_provincia)
crs(precip_tot_2014)

##Corte de pp_2014

pp_2014_canta <- crop(precip_tot_2014, canta_provincia) %>%
  raster::mask(canta_provincia)

plot(pp_2014_canta, main = "Precipitación total de Canta en el año 2014")

##Corte de tm_2014

tm_2014_canta <- crop(tm_prom_2014, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(tm_2014_canta, main = "Temperatura promedio de Canta en el año 2014")

##Indice de aridez en Canta 2014---------------------------------------------------------------------------

Indice_aridez_14 <- (pp_2014_canta)/(tm_2014_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez_14, main = "Indice de aridez para Canta en el año 2014") 

##Indice termopluviometro dantin y revenga en Canta 2014---------------------------------------------------

Indice_termo_14 <- (100 * tm_2014_canta) / (pp_2014_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termo_14,
     main = "Indice de Dantin y Revenga para Canta 2014")

#Canta 2015-------------------------------------------------------------------------------------

#Precipitacion_2015

pp_1_15 <- raster("pp/wc2.1_2.5m_prec_2015-01.tif")
pp_2_15 <- raster("pp/wc2.1_2.5m_prec_2015-02.tif")
pp_3_15 <- raster("pp/wc2.1_2.5m_prec_2015-03.tif")
pp_4_15 <- raster("pp/wc2.1_2.5m_prec_2015-04.tif")
pp_5_15 <- raster("pp/wc2.1_2.5m_prec_2015-05.tif")
pp_6_15 <- raster("pp/wc2.1_2.5m_prec_2015-06.tif")
pp_7_15 <- raster("pp/wc2.1_2.5m_prec_2015-07.tif")
pp_8_15 <- raster("pp/wc2.1_2.5m_prec_2015-08.tif")
pp_9_15 <- raster("pp/wc2.1_2.5m_prec_2015-09.tif")
pp_10_15 <- raster("pp/wc2.1_2.5m_prec_2015-10.tif")
pp_11_15 <- raster("pp/wc2.1_2.5m_prec_2015-11.tif")
pp_12_15 <- raster("pp/wc2.1_2.5m_prec_2015-12.tif")

precip_tot_2015 <- pp_1_15 + pp_2_15 + pp_3_15 + pp_4_15 + pp_5_15 + pp_6_15 + pp_7_15 + pp_8_15 +
  pp_9_15 + pp_10_15 + pp_11_15 + pp_12_15
plot(precip_tot_2015, main = "Precipitación total del año 2015")

#Temperatura media anual del 2015

#Temperatura máxima

tmax_1_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-01.tif")
tmax_2_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-02.tif")
tmax_3_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-03.tif")
tmax_4_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-04.tif")
tmax_5_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-05.tif")
tmax_6_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-06.tif")
tmax_7_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-07.tif")
tmax_8_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-08.tif")
tmax_9_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-09.tif")
tmax_10_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-10.tif")
tmax_11_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-11.tif")
tmax_12_15 <- raster("tmax/wc2.1_2.5m_tmax_2015-12.tif")

tmax_2015 <- (tmax_1_15 + tmax_2_15 + tmax_3_15 + tmax_4_15 + tmax_5_15 +
                tmax_6_15 + tmax_7_15 + tmax_8_15 + tmax_9_15 + tmax_10_15 +
                tmax_11_15 + tmax_12_15) / 12
plot(tmax_2015, main = "Temperatura máxima media anual del año 2015")

#Temperatura mínima


tmin_1_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-01.tif")
tmin_2_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-02.tif")
tmin_3_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-03.tif")
tmin_4_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-04.tif")
tmin_5_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-05.tif")
tmin_6_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-06.tif")
tmin_7_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-07.tif")
tmin_8_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-08.tif")
tmin_9_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-09.tif")
tmin_10_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-10.tif")
tmin_11_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-11.tif")
tmin_12_15 <- raster("tmin/wc2.1_2.5m_tmin_2015-12.tif")

tmin_2015 <- (tmin_1_15 + tmin_2_15 + tmin_3_15+ tmin_4_15 + tmin_5_15 +
                tmin_6_15 + tmin_7_15 + tmin_8_15 + tmin_9_15 + tmin_10_15 +
                tmin_11_15 + tmin_12_15) / 12
plot(tmin_2015, 
     main = "Temperatura mínima media anual del 2015")


##Temperatura media anual

tm_prom_2015 <- (tmax_2015 + tmin_2015) / 2
plot(tm_prom_2015, main = "Temperatura media (°C) del año 2015")

#Cortar para Canta 2015-------------------------------------------------------------------------

##Cargar shape Canta

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)
crs(canta_provincia)
crs(canta_provincia)

#Corte de pp_2015

pp_2015_canta <- crop(precip_tot_2015, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(pp_2015_canta, main = "Precipitación total de Canta en el año 2015")

#Corte de tm_2015

tm_2015_canta <- crop(tm_prom_2015, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(tm_2015_canta, main = "Temperatura promedio de Canta en el año 2015")

##Indice de aridez en Canta 2015---------------------------------------------------------------------------

Indice_aridez_15 <- (pp_2015_canta)/(tm_2015_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez_15, main = "Indice de aridez para Canta en el año 2015")

##Indice termopluviometro dantin y revenga en Canta 2015---------------------------------------------------

Indice_termo_15 <- (100 * tm_2015_canta) / (pp_2015_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termo_15,
     main = "Indice de Dantin y Revenga para Canta 2015")

#Canta 2016-------------------------------------------------------------------------------------

#precipitacion_2016

pp_1_16 <- raster("pp/wc2.1_2.5m_prec_2016-01.tif")
pp_2_16 <- raster("pp/wc2.1_2.5m_prec_2016-02.tif")
pp_3_16 <- raster("pp/wc2.1_2.5m_prec_2016-03.tif")
pp_4_16 <- raster("pp/wc2.1_2.5m_prec_2016-04.tif")
pp_5_16 <- raster("pp/wc2.1_2.5m_prec_2016-05.tif")
pp_6_16 <- raster("pp/wc2.1_2.5m_prec_2016-06.tif")
pp_7_16 <- raster("pp/wc2.1_2.5m_prec_2016-07.tif")
pp_8_16 <- raster("pp/wc2.1_2.5m_prec_2016-08.tif")
pp_9_16 <- raster("pp/wc2.1_2.5m_prec_2016-09.tif")
pp_10_16 <- raster("pp/wc2.1_2.5m_prec_2016-10.tif")
pp_11_16 <- raster("pp/wc2.1_2.5m_prec_2016-11.tif")
pp_12_16 <- raster("pp/wc2.1_2.5m_prec_2016-12.tif")

precip_tot_2016 <- pp_1_16 + pp_2_16 + pp_3_16 + pp_4_16 + pp_5_16 + pp_6_16 + pp_7_16 + pp_8_16 +
  pp_9_16 + pp_10_16 + pp_11_16 + pp_12_16
plot(precip_tot_2016, main = "Precipitación total del año 2016")

#temperatura media anual del 2016

#temperatura máxima

tmax_1_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-01.tif")
tmax_2_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-02.tif")
tmax_3_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-03.tif")
tmax_4_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-04.tif")
tmax_5_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-05.tif")
tmax_6_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-06.tif")
tmax_7_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-07.tif")
tmax_8_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-08.tif")
tmax_9_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-09.tif")
tmax_10_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-10.tif")
tmax_11_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-11.tif")
tmax_12_16 <- raster("tmax/wc2.1_2.5m_tmax_2016-12.tif")

tmax_2016 <- (tmax_1_16 + tmax_2_16 + tmax_3_16 + tmax_4_16 + tmax_5_16 +
                tmax_6_16 + tmax_7_16 + tmax_8_16 + tmax_9_16 + tmax_10_16 +
                tmax_11_16 + tmax_12_16) / 12
plot(tmax_2016, main = "Temperatura máxima media anual del año 2016")

# temperatura mínima

tmin_1_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-01.tif")
tmin_2_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-02.tif")
tmin_3_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-03.tif")
tmin_4_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-04.tif")
tmin_5_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-05.tif")
tmin_6_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-06.tif")
tmin_7_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-07.tif")
tmin_8_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-08.tif")
tmin_9_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-09.tif")
tmin_10_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-10.tif")
tmin_11_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-11.tif")
tmin_12_16 <- raster("tmin/wc2.1_2.5m_tmin_2016-12.tif")

tmin_2016 <- (tmin_1_16 + tmin_2_16 + tmin_3_16+ tmin_4_16 + tmin_5_16 +
                tmin_6_16 + tmin_7_16 + tmin_8_16 + tmin_9_16 + tmin_10_16 +
                tmin_11_16 + tmin_12_16) / 12
plot(tmin_2016, main = "Temperatura mínima media anual del 2016")

#temperatura media anual

tm_prom_2016 <- (tmax_2016 + tmin_2016) / 2
plot(tm_prom_2016,
     main = "Temperatura media (°C) del año 2016")
#Cortar para Lima 2016-------------------------------------------------------------------------

#cargar shape Lima

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)
crs(canta_provincia)
crs(precip_tot)

#coratar pp_2016

pp_2016_canta <- crop(precip_tot_2016, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(pp_2016_canta, main = "Precipitación total de Canta en el año 2016")

#cortar tm_2016

tm_2016_canta <- crop(tm_prom_2016, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(tm_2016_canta, main ="Temperatura promedio de Canta en el eño 2016")

##Indice de aridez en Canta 2016--------------------------------------------------------------------------

Indice_aridez_16 <- (pp_2016_canta)/(tm_2016_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez_16, main = "Indice de aridez para Canta en el año 2016")

##Indice termopluviometro dantin y revenga en Canta 2016--------------------------------------------------

Indice_termo_16 <- (100 * tm_2016_canta) / (pp_2016_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termo_16,
     main = "Indice de Dantin y Revenga para Lima 2016")

#Canta 2017------------------------------------------------------------------------------------

#Precipitacion_2017

pp_1_2017 <- raster("pp/wc2.1_2.5m_prec_2017-01.tif")
pp_2_2017 <- raster("pp/wc2.1_2.5m_prec_2017-02.tif")
pp_3_2017 <- raster("pp/wc2.1_2.5m_prec_2017-03.tif")
pp_4_2017 <- raster("pp/wc2.1_2.5m_prec_2017-04.tif")
pp_5_2017 <- raster("pp/wc2.1_2.5m_prec_2017-05.tif")
pp_6_2017 <- raster("pp/wc2.1_2.5m_prec_2017-06.tif")
pp_7_2017 <- raster("pp/wc2.1_2.5m_prec_2017-07.tif")
pp_8_2017 <- raster("pp/wc2.1_2.5m_prec_2017-08.tif")
pp_9_2017 <- raster("pp/wc2.1_2.5m_prec_2017-09.tif")
pp_10_2017 <- raster("pp/wc2.1_2.5m_prec_2017-10.tif")
pp_11_2017 <- raster("pp/wc2.1_2.5m_prec_2017-11.tif")
pp_12_2017 <- raster("pp/wc2.1_2.5m_prec_2017-12.tif")

precip_tot_2017 <- pp_1_2017 + pp_2_2017 + pp_3_2017 + pp_4_2017 + pp_5_2017 + pp_6_2017 + pp_7_2017 + pp_8_2017 + pp_9_2017 + pp_10_2017 + pp_11_2017 + pp_12_2017
plot(precip_tot_2017, main = "Precipitación total del año 2017")

#Temperatura media anual del 2017

#Temperatura máxima

tmax_1_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-01.tif")
tmax_2_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-02.tif")
tmax_3_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-03.tif")
tmax_4_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-04.tif")
tmax_5_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-05.tif")
tmax_6_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-06.tif")
tmax_7_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-07.tif")
tmax_8_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-08.tif")
tmax_9_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-09.tif")
tmax_10_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-10.tif")
tmax_11_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-11.tif")
tmax_12_17 <- raster("tmax/wc2.1_2.5m_tmax_2017-12.tif")

tmax_2017 <- (tmax_1_17 + tmax_2_17 + tmax_3_17 + tmax_4_17 + tmax_5_17 +
                tmax_6_17 + tmax_7_17 + tmax_8_17 + tmax_9_17 + tmax_10_17 +
                tmax_11_17 + tmax_12_17) / 12

plot(tmax_2017, main = "Temperatura máxima media anual del año 2017")

#Temperatura mínima

tmin_1_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-01.tif")
tmin_2_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-02.tif")
tmin_3_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-03.tif")
tmin_4_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-04.tif")
tmin_5_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-05.tif")
tmin_6_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-06.tif")
tmin_7_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-07.tif")
tmin_8_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-08.tif")
tmin_9_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-09.tif")
tmin_10_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-10.tif")
tmin_11_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-11.tif")
tmin_12_17 <- raster("tmin/wc2.1_2.5m_tmin_2017-12.tif")

tmin_2017 <- (tmin_1_17 + tmin_2_17 + tmin_3_17+ tmin_4_17 + tmin_5_17 +
                tmin_6_17 + tmin_7_17 + tmin_8_17 + tmin_9_17 + tmin_10_17 +
                tmin_11_17 + tmin_12_17) / 12
plot(tmin_2017, main = "Temperatura mínima media anual del 2017")

#temperatura media anual

tm_prom_2017 <- (tmax_2017 + tmin_2017) / 2
plot(tm_prom_2017,
     main = "Temperatura media (°C) del año 2017")

#Cortar para Canta 2017-------------------------------------------------------------------------

##cargar shape Canta

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)

##cortando pp_Canta

crs(lima_provincia)
crs(precip_tot)
pp_2017_canta <- crop(precip_tot_2017, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(pp_2017_canta , main = "Precipitación total de Canta en el año 2017")

##cortando tm_Canta

tm_2017_canta <- crop(tm_prom_2017, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(tm_2017_canta, main = "Temperatura promedio de Canta en el año 2017")

##Indice de aridez en Canta 2017-------------------------------------------------------------------------

Indice_aridez_17 <- (pp_2017_canta)/(tm_2017_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez_17, main = "Indice de aridez para Canta en el año 2017")

##Indice termopluviometro dantin y revenga en Lima 2017-------------------------------------------------

Indice_termo_17 <- (100 * tm_2017_canta) / (pp_2017_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termo_17, main = "Indice de Dantin y Revenga para Canta 2017")

#Canta 2018-----------------------------------------------------------------------------------

#Precipitacion_2018

pp_1_2018 <- raster("pp/wc2.1_2.5m_prec_2018-01.tif")
pp_2_2018 <- raster("pp/wc2.1_2.5m_prec_2018-02.tif")
pp_3_2018 <- raster("pp/wc2.1_2.5m_prec_2018-03.tif")
pp_4_2018 <- raster("pp/wc2.1_2.5m_prec_2018-04.tif")
pp_5_2018 <- raster("pp/wc2.1_2.5m_prec_2018-05.tif")
pp_6_2018 <- raster("pp/wc2.1_2.5m_prec_2018-06.tif")
pp_7_2018 <- raster("pp/wc2.1_2.5m_prec_2018-07.tif")
pp_8_2018 <- raster("pp/wc2.1_2.5m_prec_2018-08.tif")
pp_9_2018 <- raster("pp/wc2.1_2.5m_prec_2018-09.tif")
pp_10_2018 <- raster("pp/wc2.1_2.5m_prec_2018-10.tif")
pp_11_2018 <- raster("pp/wc2.1_2.5m_prec_2018-11.tif")
pp_12_2018 <- raster("pp/wc2.1_2.5m_prec_2018-12.tif")

precip_tot_2018 <- pp_1_2018 + pp_2_2018 + pp_3_2018 + pp_4_2018 + pp_5_2018 +
  pp_6_2018 + pp_7_2018 + pp_8_2018 + pp_9_2018 + pp_10_2018 + pp_11_2018 + pp_12_2018
plot(precip_tot_2018, main = "Precipitación total del año 2018")

#Temperatura media anual del 2018

##Temperatura máxima

tmax_1_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-01.tif")
tmax_2_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-02.tif")
tmax_3_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-03.tif")
tmax_4_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-04.tif")
tmax_5_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-05.tif")
tmax_6_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-06.tif")
tmax_7_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-07.tif")
tmax_8_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-08.tif")
tmax_9_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-09.tif")
tmax_10_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-10.tif")
tmax_11_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-11.tif")
tmax_12_18 <- raster("tmax/wc2.1_2.5m_tmax_2018-12.tif")

tmax_2018 <- (tmax_1_18 + tmax_2_18 + tmax_3_18 + tmax_4_18 + tmax_5_18 +
                tmax_6_18 + tmax_7_18 + tmax_8_18 + tmax_9_18 + tmax_10_18 +
                tmax_11_18 + tmax_12_18) / 12
plot(tmax_2018, 
     main = "Temperatura máxima media anual del año 2018")

##Temperatura mínima

tmin_1_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-01.tif")
tmin_2_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-02.tif")
tmin_3_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-03.tif")
tmin_4_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-04.tif")
tmin_5_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-05.tif")
tmin_6_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-06.tif")
tmin_7_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-07.tif")
tmin_8_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-08.tif")
tmin_9_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-09.tif")
tmin_10_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-10.tif")
tmin_11_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-11.tif")
tmin_12_18 <- raster("tmin/wc2.1_2.5m_tmin_2018-12.tif")

tmin_2018 <- (tmin_1_18 + tmin_2_18 + tmin_3_18+ tmin_4_18 + tmin_5_18 +
                tmin_6_18 + tmin_7_18 + tmin_8_18 + tmin_9_18 + tmin_10_18 +
                tmin_11_18 + tmin_12_18) / 12
plot(tmin_2018, 
     main = "Temperatura mínima media anual del 2018")

##Temperatura media anual

tm_prom_2018 <- (tmax_2018 + tmin_2018) / 2
plot(tm_prom_2018, main = "Temperatura media (°C) del año 2018")

#Cortar para Canta 2018------------------------------------------------------------------------

##Cargar shape Canta

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)

##Cortando pp_Canta

crs(lima_provincia)
crs(precip_tot)
pp_2018_canta <- crop(precip_tot_2018, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(pp_2018_canta, main = "Precipitacion total de Canta en el año 2018")

##Cortando tm_Canta

tm_2018_canta <- crop(tm_prom_2018, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(tm_2018_canta, main= "Temperatura promedio de Canta en el año 2018")

##Indice de aridez en Canta 2018--------------------------------------------------------------------------

Indice_aridez_18 <- (pp_2018_canta)/(tm_2018_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez_18, main = "Indice de aridez para Canta en el año 2018")

##Indice termopluviometro dantin y revenga en Canta 2018--------------------------------------------------

Indice_termo_18 <- (100 * tm_2018_canta) / (pp_2018_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termo_18, main = "Indice de Dantin y Revenga para Canta 2018")

#Canta 2014-2018-------------------------------------------------------------------------------

pp_media_anual <- (precip_tot_2014 + precip_tot_2015 + precip_tot_2016 + precip_tot_2017 +
                     precip_tot_2018)/5
plot(pp_media_anual, main = "Precipitación media anual")

te_media_anual <- (tm_prom_2014 + tm_prom_2015 + tm_prom_2016 + tm_prom_2017 + tm_prom_2018)/5

plot(te_media_anual, main = "Temperatura media anual")

##Cortando para Canta 2014-2018----------------------------------------------------------------
##Cargar shape Canta

canta_provincia <- shapefile("CANTA.shp")
plot(canta_provincia)

##Cortando pp_Canta

crs(canta_provincia)
crs(precip_tot)
pp_media_anual_canta <- crop(pp_media_anual, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(pp_media_anual_canta, main = "Promedio anual de la precipitacion en Canta 2014-2018")

##Cortando tm_Canta

te_media_anual_canta <- crop(te_media_anual, canta_provincia) %>%
  raster::mask(canta_provincia)
plot(te_media_anual_canta, main = "Promedio anual de la temperatura media en Canta 2014-2018")

##Indice de aridez en Canta 2014-2018----------------------------------------------------------------------

Indice_aridez <- (pp_media_anual_canta)/(te_media_anual_canta + 10) %>%
  raster::mask(canta_provincia)
plot(Indice_aridez, main = "Indice de aridez para Canta 2014-2018")


##Indice termopluviometro dantin y revenga en Canta 2014-2018----------------------------------------------

Indice_termoplu <- (100 * te_media_anual_canta) / (pp_media_anual_canta) %>%
  raster::mask(canta_provincia)
plot(Indice_termoplu, main = "Indice de Dantin y Revenga para Canta 2014-2018")

##Guardar raster

writeRaster(pp_media_anual_canta, filename = "Pp_2014-2018_Canta",
            format= "GTiff")
writeRaster(te_media_anual_canta, filename = "tm_2014-2018_Canta",
            format= "GTiff")
writeRaster(Indice_aridez, filename = "indice_aridez_Canta_2014-2018",
            format= "GTiff")
writeRaster(Indice_termoplu, filename = "indice_termopluv_Canta_2014-2018",
            format= "GTiff")

