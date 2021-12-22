# the necessary packages----
library(DT)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)
library(gridExtra)
library(ggthemes)
library(shinyjs)
library(scales)
library(leaflet)
library(reshape)

# 
# the list of regions----
 regions_global <- c(
   ' ',
   'Albany',              
   'Atlanta',             
   'BaltimoreWashington', 
   'Boise',               
   'Boston',
   'BuffaloRochester',    
   'California',          
   'Charlotte',           
   'Chicago',             
   'CincinnatiDaytonColumbus',            
   'DallasFtWorth',       
   'Denver',              
   'Detroit',             
   'GrandRapidsGreatLakes',          
   'HarrisburgScranton',  
   'HartfordSpringfield', 
   'Houston',             
   'IndianapolisJacksonville',        
   'LasVegas',            
   'LosAngeles',          
   'Louisville',          
   'MiamiFtLauderdale',
   'Midsouth',            
   'Nashville',           
   'NewOrleansMobile',    
   'NewYork',             
   'Northeast',
   'NorthernNewEngland',  
   'Orlando',             
   'Philadelphia',        
   'PhoenixTucson',       
   'Pittsburgh',
   'Plains',              
   'Portland',            
   'RaleighGreensboro',   
   'RichmondNorfolk',     
   'Roanoke',
   'Sacramento',          
   'SanDiego',            
   'SanFrancisco',        
   'Seattle',             
   'SouthCarolina',
   'SouthCentral',        
   'Southeast',           
   'Spokane',             
   'StLouis',             
   'Syracuse',
   'Tampa',               
   'TotalUS',             
   'West',                
   'WestTexNewMexico'
)
# 
# the list of Months----
month_global <- c(
  ' ',
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12
)
#month_global <- as.integer(month_global)
# 
# # the list of Months----
# month <- c(
#   'January',
#   'Febuary',
#   'March',
#   'April',
#   'May',
#   'June',
#   'July',
#   'August',
#   'September',
#   'October',
#   'November',
#   'December'
# )
# 
# library(data.table)
# library(DT)
# library(dplyr)
# library(ggplot2)
# library(hrbrthemes)
# ################### Data Overview Graphs
# data <- fread(input = "/Users/qwerty/Desktop/Shiny6893/avocado.csv", na=c('N/A','NA'))
# dat <- read.csv("/Users/qwerty/Desktop/Shiny6893/avocado.csv")
pred <- read.csv("prediction.csv")
# # Price distribution by type: conventional
# a <-filter(data, type == "conventional")
# g1 <- a$AveragePrice
# hist(g1,
#      main="Price distribution by type(Conventional)",
#      xlab="Average Price",
#      ylab="Frequency",
#      col="darkmagenta"
# )
# # Price distribution by type: organic
# b <-filter(data, type == "organic")
# g2 <- b$AveragePrice
# hist(g2,
#      main="Price distribution by type(Organic)",
#      xlab="Average Price",
#      ylab="Frequency",
#      col="#00FFFF"
# )
# # Price distribution by region: Albany
# c <-filter(data, region == "Albany")
# g3 <- c$AveragePrice
# hist(g3,
#      main="Price distribution by region(Albany)",
#      xlab="Average Price",
#      ylab="Frequency",
#      col="#0035FF"
# )
# # Price trend by state: Albany
# d <-filter(data, region == "Albany")
# g4 <-d %>%
#   group_by(Date) %>%
#   summarise_at(vars(AveragePrice), list(AveragePrice = mean))
# ggplot(g4, aes(x=Date, y=AveragePrice)) +
#   geom_line(color="#69b3a2") +
#   theme_minimal()+
#   ggtitle("Price trend by state: Albany")
# 
# g4 <- as.factor(g4$Date)
# plot(g4, type = "p", col = "red",
#      xlab = "Date", ylab = "AveragePrice",
#      main = "Price trend by state: Albany")
# 
# lines(t, type = "o", col = "blue")
# lines(m, type = "o", col = "green")
# 
# ggplot(g4, aes(x=Date, y=AveragePrice)) +
#   # geom_segment(aes(x = Date, xend = Date,
#   #                  y = 0, yend = AveragePrice), size = 0.005) +
#   geom_point(size = 0.05, color = "red",
#              fill = alpha("orange", 0.005),
#              alpha = 0.7, shape = 21, stroke = 0.5) +
#   # geom_smooth(method = 'lm', formula = y~x, 
#   #             se = FALSE, fullrange = TRUE,
#   #             size = 1.5, color = 'green') +
#   # xlim(2017, 2020) +
#   #scale_y_continuous(labels = comma) +
#   ggtitle(paste0('Prediction for the Month of ', 
#                  "input$months_units_sold", '/20')) +
#   labs(x = 'Date', y = 'Avg Price') +
#   theme_minimal(base_size = 16)

####################################################
# # GRAGH 1, 2: Price and consumption trend by state and type: Albany & conventional
# d <-filter(pred, region == "Albany", type=="conventional", month=="1")
# d <-filter(pred, region == "Albany", type=="conventional")
# #Price trend by state and type: Albany & conventional
# ggplot(d, aes(x=month, y=AveragePrice)) +
#   geom_line(color="red") +
#   scale_y_continuous(name = " ", breaks = months_numeric) +
#   theme_minimal()+
#   ggtitle("Price trend by state and type: Albany & conventional")
# #Price trend by state and type: Albany & conventional
# ggplot(d, aes(x=month, y=Total.Volume)) +
#   geom_line(color="blue") +
#   theme_minimal()+
#   ggtitle("Consumption trend by state and type: Albany & conventional")
# 
#GRAGH 3: Revenue(Price x consumption) trend by state and type: Albany & conventional
# e <-filter(pred, region == "Albany", type=="conventional", month==1|month==2|month==3)
# #Revenue trend by state and type: Albany & conventional
# ggplot(e, aes(x=month, y=AveragePrice*Total.Volume, fill = ifelse(month == "2", "Highlighted", "Normal"))) +
#   geom_bar(stat="identity") +
#   labs(y= "Revenue", x = "Month") +
#   theme(legend.position = "none") +
#   #scale_fill_manual( values = c( "2"="red", "0"="darkgray" ), guide = "none")+
#   geom_text(aes(label = round(AveragePrice*Total.Volume)), size = 3, position = position_stack(vjust = 1.05))+
#   #theme_minimal()+
#   ggtitle("Revenue trend by state and type: Albany & conventional")

