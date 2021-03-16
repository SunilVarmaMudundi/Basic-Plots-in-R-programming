#reading dataset from the given URL link given.
link <- "https://github.com/SavioSal/datasets/raw/master/Bank%20Churn_Modelling.csv"
#reading/assigning data to variable called info
info <- read.csv(link)
#calling variable info
info
#calling installed libraries ggplot2 and dplyr
#ggplot2 is a data visualization package for the statistical programming language R.
#It is a general scheme for data visualization which breaks up graphs into semantic components such as scales and layers.
library(ggplot2)
#dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:
#mutate() adds new variables that are functions of existing variables
#select() picks variables based on their names.
#filter() picks cases based on their values.
#summarize() reduces multiple values down to a single summary.
#arrange() changes the ordering of the rows.
library(dplyr)
#using chain progrma(ctrl+shift+M). We are removing unwanted columns in the following steps.
#assigning info data from the top into new variable i.e. info_1
info_1<-info %>%
  dplyr::select(-RowNumber, -CustomerId, -Surname) %>% #remove unwanted column 
  mutate(Geography = as.factor(Geography),
         Gender = as.factor(Gender),
         HasCrCard = as.factor(HasCrCard),
         IsActiveMember = as.factor(IsActiveMember),
         Exited = as.factor(Exited),
         Tenure = as.factor(Tenure),
         NumOfProducts = as.factor(NumOfProducts))


#(a)
#doing a histogramal plot for tenutre column of the data
ggplot(info_1, aes(Tenure, fill = Tenure)) +
  geom_bar() +
  theme(legend.position = 'none')
#(b)
#Plotting NumOfproducts using histogram plot.
ggplot(data_2, aes(NumOfProducts, fill = NumOfProducts)) +
  geom_bar() +
  theme(legend.position = 'none')
#(c)
#The scales packages provides the internal scaling infrastructure used by ggplot2,
#and gives us tools to override the default breaks, labels, transformations and palettes
library(scales)
ggplot(data_2, aes(x = Age, fill = Exited)) +
  geom_boxplot(binwidth = 5) +
  theme_minimal() +
  scale_x_continuous(breaks = seq(0,100,by=10), labels = comma)
#(d)
#the complete operation is done using chain link operator (ctrl+shift+M)
#library(tidyverse) will load the core tidyverse packages:
'ggplot2,dplyr,tidyr,readr,purrr,tibble,stringr,forcats,' 
library(tidyr)
library(tidyselect)
library(tidyverse)
#we are plotting some of the columns like gender, geography, HascrCaed, Is ActiveMember,NumOfproducts,Tenure
#we are selecting coloumns excluding excited data
#using ggplot we are visualizing data mentioned in dataset.
info_1 %>%
  dplyr::select(-Exited) %>% 
  keep(is.factor) %>%
  gather() %>%
  group_by(key, value) %>% 
  summarize(n = n()) %>% 
  ggplot() +
  geom_bar(mapping=aes(x = value, y = n, fill=key), color="black", stat='identity') + 
  coord_flip() +
  facet_wrap(~ key, scales = "free") +
  theme_minimal() +
  theme(legend.position = 'none')
#(e)
#correlation plot 
#we are obtaining correlation plot for credit score, Age,, Balance and Estimated Salary
library(ggcorrplot)
info_2 <- names(which(sapply(info_1, is.numeric)))
corr <- cor(info_1[,info_2], use = 'pairwise.complete.obs')
ggcorrplot(corr, lab = TRUE)





  

