library(readxl)
library(dplyr)
library(scales)

#Setting the working directory
setwd('C:/Users/Owner/Documents/2Data')

#Pulling the data
df <- read_excel('bls.xlsx')

#Cleaning the data
df_new <- df %>%  mutate(month = as.Date((paste(df$periodName, '01', df$year)), format = '%b %d %Y')) %>% #Creating the x-axis data
  filter(df$periodName != 'Annual') %>% #Removing the annual data
  mutate(value = as.numeric(value)) #Creating the y-axis data
