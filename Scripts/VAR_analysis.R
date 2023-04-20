# Description
# VAR analysis for Mpumi - Xolani Sibande 16 April 2023
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
data <- read_rds(here("Outputs", "artifacts_cleanup.rds"))
data_tbl <- data$data_tbl

# VAR ---------------------------------------------------------------------
data_ts <- 
  data_tbl %>% 
  dplyr::select(-Date) %>% 
  map(~ ts(.x, start = 1980, end = 2020, frequency = 1)) 

y <- cbind(data_ts$CPI,
           data_ts$GFCF)
# data_ts$PFC,
# data_ts$G
# data_ts$M3,
# data_ts$REER
# data_ts$OIL_P,
# data_ts$M_P
# # data_ts$IP) # Choose what is sensible, the system cannot run


# VAR select --------------------------------------------------------------

lag_selection <- VARselect(y, type = "const")
lag_selection$selection


# VAR ---------------------------------------------------------------------
var_model <- VAR(y, p = 2, type = "const")
summary(var_model)


# Impulse responses -------------------------------------------------------
cpi_gfcf_irf <- irf(var_model, n.ahead = 10)
plot(cpi_gfcf_irf)


# Granger causality -------------------------------------------------------
causality(var_model, cause = "data_ts.CPI") # Can only do with two variables # can switch the direction



# Export ---------------------------------------------------------------
artifacts_var <- list (
 data_ts = data_ts,
 lag_selection = lag_selection,
 var_model = var_model, 
 cpi_gfcf_irf = cpi_gfcf_irf 
)

write_rds(artifacts_var, file = here("Outputs", "artifacts_var.rds"))


