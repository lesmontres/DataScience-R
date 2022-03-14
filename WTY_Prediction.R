library(tidyverse) 
library(lubridate)
library(ISOweek)
library(glmnet)
library(glmnetUtils)
library(zoo)
library(modelr)
library(fastDummies)
library(Metrics)
library(modelr)


#Train Data
#Using historical data from the beginning of the year up to a day before
#In this case 1/1/2020-4/23/2020)
#The reason for this time frame is because we suspect that
#market trend stops following the usual pattern 
#due to COVID-19
df <- read_csv("4.23.csv", col_names = TRUE)
df$Date <- mdy(df$Date) 

#Create Standard_7 and Express_7 variable
#Filter rows that Standard_7 and Express_7 are NA
df <- df %>% 
  filter(Date >= "2020-01-01") %>% 
  mutate( Express_7 = lag(Express, 7), Standard_7 = lag(Standard, 7)) %>% 
  filter(is.na(Express_7) == FALSE)

#Visualize
#Express packages over time at different origin
ggplot(data = covid) + 
  geom_point(mapping = aes(y= Express, x = Date, color = Origin)) 
#Standard packages over time at different origin
ggplot(data = covid) + 
  geom_point(mapping = aes(y= Standard, x = Date, color = Origin)) 

#Model predict Standard
std <- lm(Standard ~ factor(Origin) +  Standard_7 + Date, df)
summary(std)

#Model predict Express
exp <- lm(Express  ~ factor(Origin) +  Express_7 + Date, df)
summary(exp)

#Prepare data to make the prediction using model's coeficients
#Create a data frame with 30 origin and fill in current Date
pred <- data.frame(unique(df$Origin)) %>% 
  mutate(Date = "2020-04-24") %>% 
  rename(Origin = "unique.df.Origin.") 

pred$Date <- as_date(pred$Date)

#Extract Standard_7 and Express_7 values appropriate for the current date 
lag_7 <- df %>% 
  filter(Date == "2020-04-17") %>% 
  select(Origin, Express, Standard) %>% 
  rename(Express_7 = Express, Standard_7 = Standard)

#Joining the last two tables to create 
pred <- full_join(pred, lag_7)

#Making the prediction for 4.24
pred$pred_Standard = predict(std,pred)
pred$pred_Express = predict(exp,pred)

predicted <- pred %>% 
  select(Origin, Date, pred_Express, pred_Standard) %>% 
  rename(Express = pred_Express, Standard = pred_Standard)

write_csv(pred, "predict.4.24 .csv")


#Checking error for prediction
actual<- read_csv("4.27.csv", col_names = TRUE)
actual$Date <- mdy(actual$Date) 
actual <- actual %>%  
  filter(Date == "2020-04-24")

#Calculating error after prediction made using updated data
rmse(actual$Standard, predicted$Standard)
rmse(actual$Express, predicted$Express) 


