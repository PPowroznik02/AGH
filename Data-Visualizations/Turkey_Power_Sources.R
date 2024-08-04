library(ggplot2)
library(raster)            
library(nlme)
library(sf)


elektrownie <- read.csv("global_power_plant_database_v_1_3/global_power_plant_database.csv")
elektrownie_turcja <- elektrownie[elektrownie$country == "TUR", ]

# Load shapefile
turcja <- read_sf('gadm41_TUR_shp/gadm41_TUR_1.shp')


udzial_energii <- read.csv("share-elec-by-source.csv")
udzial_energii_turcja <- udzial_energii[udzial_energii$Entity == "Turkey", ]


ggplot(turcja) +
  geom_sf(data = turcja, color = "grey95", fill = "lightgray") +
  geom_sf_text(aes(label = NAME_1), size = 2) +
  geom_point(data = elektrownie_turcja, aes(x = longitude, y = latitude, color = primary_fuel, size = capacity_mw), alpha=0.7)  + 
  theme_void() + 
  labs(color="Source type", size="Plant capasity MW") +
  scale_size_continuous(breaks = c(50, 500, 1000, 1500, 2000, 2500))+
  ggtitle("Turkey power sources")+
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data=udzial_energii_turcja, aes(x=Year)) +
  geom_line(aes(y = Coal, color = "Coal"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Gas, color = "Gas"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Hydro, color = "Hydro"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Solar, color = "Solar"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Wind, color = "Wind"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Oil, color = "Oil"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Nuclear, color = "Nuclear"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Other, color = "Other"), size = 1.5, alpha=0.6)+
  geom_line(aes(y = Bioenergy, color = "Bioenergy"), size = 1.5, alpha=0.6)+
  theme_classic() +
  theme(panel.grid.major.y = element_line(), panel.grid.minor.y = element_line())+
  labs(x = "Year",y = "%",color = "Legend") 

######################################################
  


  