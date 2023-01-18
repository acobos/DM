library(tidyverse)

# drugs
d <- rio::import("data/who-drug.xlsx") %>%
  select(code = Code2, decode = Decode2) %>%
  mutate(decode = str_to_lower(decode)) %>%
  pull(decode) %>%
  unique()

d[str_detect(d, "mab")]


# aes
ae <- rio::import("data/meddra.xlsx") %>%
  pull(decode) %>%
  unique()

ae[str_detect(ae, "ha?emorr")]
