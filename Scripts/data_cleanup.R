# Description
 # Numbers for Mpumi 16 April 2022
# Preliminaries -----------------------------------------------------------
# core
library(tidyverse)
library(readr)
library(readxl)
library(here)
library(lubridate)
library(xts)
library(broom)
library(glue)
library(scales)
library(kableExtra)
library(pins)
library(timetk)
library(uniqtag)

# graphs
library(PNWColors)
library(patchwork)

# eda
library(psych)
library(DataExplorer)
library(skimr)

# econometrics
library(tseries)
library(strucchange)
library(vars)
library(urca)
library(mFilter)
library(car)

# Functions ---------------------------------------------------------------
source(here("Functions", "fx_plot.R"))

# Import -------------------------------------------------------------
data_tbl <- 
  read.csv(here("Data", "Switzerland.csv"), sep = ";", stringsAsFactors = FALSE) %>% 
  as_tibble() %>% 
  rename("Date" = "X") %>% 
  mutate(Date = parse_date_time(Date, orders = "Y")) %>% 
  mutate(PFC = as.numeric(PFC), IP = as.numeric(IP)) ## edited original data with two periods

# EDA ---------------------------------------------------------------
 data_tbl %>% 
  skim()

# Graphing ---------------------------------------------------------------
data_gg <- 
  data_tbl %>% 
  fx_plot()

# Export ---------------------------------------------------------------
artifacts_cleanup <- list (
   data_tbl = data_tbl,
   data_gg = data_gg
)

write_rds(artifacts_cleanup, file = here("Outputs", "artifacts_cleanup.rds"))


