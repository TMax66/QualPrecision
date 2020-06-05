library(readxl)
library(tidyverse)
library(knitr)
library(kableExtra)
 
dati <- read_excel("~/Scrivania/Quali.xlsx")

dt<-dati %>% 
  filter(mp=="MP00/001") %>% 
  #select_if(~ !any(is.na(.))) %>% 
  discard(~all(is.na(.x))) %>% 
  mutate(s = rowSums(select(., starts_with("r")))) %>%
  mutate(k=n()) %>% 
  mutate(pi=s/ncol(select(dati, starts_with("r"))))


#repliche<-ncol(select(dt, starts_with("r")))
pi<-dt$pi
k<-dt$k
P<-mean(pi)

sigma2_r<-sum(pi*(1-pi))/k
sigma2_L<-(sum((pi-P)^2))/(k-1)

sigma2_R=sigma2_r+sigma2_L

sd_r<-sqrt(sigma2_r)
sd_R<-sqrt(sigma2_R)

  
tab<-round(tibble("P"=P, sigma2_r,sigma2_L,sigma2_R,sd_r,sd_R, "r"=2*sd_r,
       "R"=2*sd_R),2) %>% 
  slice(1) %>% 
  kable() %>% 
  kable_styling()
   


  
  



