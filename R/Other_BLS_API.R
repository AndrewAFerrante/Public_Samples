#blsAPI(payload = NA, api_version = 1, return_data_frame = FALSE)

library(blsAPI)
library(dplyr)
library(ggplot2)
library(scales)


#Payload Examples
#Link to SeriesID Database: https://www.bls.gov/help/hlpforma.htm

#Current Employment Statistics - CES (National)
#Seasonally Adjusted, Supersector, Industry, and Data Type codes can all be found in the link above
#Series ID    CEU0800000003
#Positions       Value           Field Name
#1-2             CE              Prefix
#3               U               Seasonal Adjustment Code
#4-11		         08000000	       Supersector and Industry Codes
#12-13           03              Data Type Code

#Pulling the data throught the BLS API
pull <- blsAPI('CEU0000000001', return_data_frame = TRUE) #Make sure to pull the data as a data frame!

#Cleaning the data
df <- pull %>% 
  mutate(month = as.Date((paste(pull$periodName, '01', pull$year)), format = '%b %d %Y')) %>% #Creating the x-axis data
  filter(pull$periodName != 'Annual') %>% #Removing the annual data
  mutate(value = as.numeric(value)) #Creating the y-axis data

#Plotting
ggplot(df) + 
  geom_line(aes(month, value)) + 
  labs(title  = 'Total US Nonfarm Employment', x = NULL, y = 'Number of jobs',
       caption = 'Source: BLS - CES. Note: Most recent month is June 2021.') +
  theme_bw() +
  scale_y_continuous(labels = comma, breaks = seq(from = 125000, to = 155000, by = 5000), 
                    limits = c(125000,155000), expand = c(0,0))
