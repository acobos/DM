# selects some PA data for ilustration of aggregation

library(tidyr)
library(readxl)
file <- "C:/Users/acobo/MEGA/ACC/Dropbox_Saalig/Estudis - Finalizados/MEN 004 - Esthen 4/50 ST/data/DFA SuperData.xls"
read_excel(file) %>% 
  filter(PDO == 7 & Item %in% c("pad", "pas") & Rep <= 3) %>% 
  arrange(Subject, Rep) %>% 
  select(Subject, Rep, Item, N) %>% 
  pivot_wider(names_from = Item, values_from = N) %>% 
  rename(patient = Subject, measurement = Rep, sbp = pas, dbp = pad) %>% 
  # para evitar potenciales problemas de uso de datos sin permiso:
  slice(1:600) -> d

rm(file)
write.table(d, file = "bp.txt", quote = FALSE, row.names = FALSE)

