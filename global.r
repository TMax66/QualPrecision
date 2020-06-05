library(shiny)
library(tidyverse)
library(googledrive)
library(googlesheets4)
library(knitr)
library(kableExtra)

##IL CODICE SEGUENTE SI FA SOLO LA PRIMA VOLTA CHE SI ACCEDE AL DRIVE DI GOOGLE
# options(gargle_oauth_cache = ".secrets")
# gargle::gargle_oauth_cache()
# drive_auth()
# list.files(".secrets/")

options(
  gargle_oauth_cache = ".secrets",
  gargle_oauth_email = TRUE
)
drive_auth()
sheets_auth(token = drive_token())
  mydrive<-drive_find(type = "spreadsheet")
id<-mydrive %>% 
  filter(name=="Qualiprecision") %>% 
  select(2)

dati<-read_sheet(id$id)



