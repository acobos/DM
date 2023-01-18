# Diseases

# Get comorbidities from Optimal I ----

setwd("C:/Users/acobo/Dropbox/Estudis/SYS 016 - OPTIMAL I/50 ST/03 Final analysis")

load("d.RData")
# data edits that could not be implemented through eCRF ----
# recorded in ./data edits/*.xls
source("02_data_edits.R", encoding = "UTF-8")
# denormalize ----
source("03_denormalize.R", encoding = "UTF-8")

# simple df of original terms for comorbidities
library(dplyr)
t07_com_det %>%
  select(pid = subject_id,
         group_repeat_key,
         condition = com_condition) -> diseases

rm(list=setdiff(ls(), "diseases"))

# to get fixed strings and coded equivalents
load("dfa.RData")

t07_com_det %>%
  select(pid = subject_id,
         group_repeat_key,
         condition_fixed = com_condition,
         PT, HLT) -> coded

codis <- left_join(diseases, coded)

rm(list=setdiff(ls(), "codis"))

# Select some original terms for examples and get the English translation ----

library(tidyverse)

unique(codis$HLT)

# some selected terms for examples
codis %>%
  filter(HLT %in% c("Asthma", "Diabetes Mellitus", "Essential hypertension",
                    "Pneumonia, organism unspecified")) %>%
  select(condition:HLT) %>%
  unique() %>%
  arrange(HLT, PT, condition) -> k


# CARE !!: free licence limited to  500000 CHARACTERS/month.
# library(deeplr)
#
# translate2(k$condition, "EN",
#            source_lang = "ES",
#            preserve_formatting = TRUE,
#            auth_key = "dc1b2db9-5259-6c38-7531-8ac3404e9131:fx") -> tr
#
# k$condition_english <- tr


k %>%
  select(condition = condition_english, PT, HLT) -> codis_terms

rm(tr, k)

codis_terms$condition

setwd("C:/Users/acobo/MEGA/ACC/Docencia/COMB- IFMiL new DACS/02 Data Management/data")
save.image("terms.RData")
