library(dplyr)
library(tidyr)
library(ggplot2)

properties <- read.csv('ReligiousProperties_coded.csv')

head(properties)

#adds a century completed column
properties$CENTURY.COMPLETED <- cut(properties$YEAR.ORIGINAL.BUILDING.COMPLETED, c(1699, 1799, 1899, 1999))
properties$CENTURY.COMPLETED <- as.character(properties$CENTURY.COMPLETED)

properties$CENTURY.COMPLETED[properties$CENTURY.COMPLETED == '(1.8e+03,1.9e+03]'] <- '19C'
properties$CENTURY.COMPLETED[properties$CENTURY.COMPLETED == '(1.9e+03,2e+03]'] <- '20C'
properties$CENTURY.COMPLETED[properties$CENTURY.COMPLETED == '(1.7e+03,1.8e+03]'] <- '18C'

clean.properties <- subset(properties, select = c('CENTURY.COMPLETED', 'CURRENT.CONGREGATION', 'ZIP.CODE', 'YEAR.ORIGINAL.BUILDING.COMPLETED', 'Phila.Register..District.', 'National.Register..Ind.', 'National.Register..District.'))

clean.properties[order(clean.properties$YEAR.ORIGINAL.BUILDING.COMPLETED),]


summary(clean.properties$YEAR.ORIGINAL.BUILDING.COMPLETED)


# Histogram of buildings completed across all years. 
ggplot(aes(x=YEAR.ORIGINAL.BUILDING.COMPLETED), data=clean.properties) +
  geom_histogram(binwidth=10) 

#Histogram of buildings completed broken down by zipcode
ggplot(aes(x=YEAR.ORIGINAL.BUILDING.COMPLETED), data=clean.properties) +
  geom_histogram(binwidth=10) +
  facet_wrap(~ZIP.CODE)

#this could become a useful scatterplot. Zips should be mapped onto neighborhoods or rough areas of the city
# and that should dictate the color
ggplot(aes(x=YEAR.ORIGINAL.BUILDING.COMPLETED, y = ZIP.CODE), data=clean.properties) +
  geom_point(aes(color=CENTURY.COMPLETED)) 





relproperties <- subset(properties, select = c('CENTURY.COMPLETED', 'ZIP.CODE', 'YEAR.ORIGINAL.BUILDING.COMPLETED','ORIGINAL.FAITH', 'CURRENT.FAITH'))

#Histogram showing counts of original faiths
ggplot(aes(x=ORIGINAL.FAITH), data=relproperties) +
  geom_histogram(stat='count') +
  coord_flip()


# scatterplot of faith, location, colored by century
ggplot(aes(x=ZIP.CODE, y=ORIGINAL.FAITH), data=relproperties) +
  geom_point(aes(color=CENTURY.COMPLETED))

#this is kind of a hacked-together timeline, showing what faith constructed churches when

ggplot(aes(x=YEAR.ORIGINAL.BUILDING.COMPLETED, y=ORIGINAL.FAITH), data=relproperties) +
  geom_point()


