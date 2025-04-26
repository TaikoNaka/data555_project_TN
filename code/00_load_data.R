here::i_am("code/00_load_data.R")

library(here)
library(readxl)

# Lodad data
data <- read_excel(here("raw_data", "IHME_GBD_2021_MORTALITY.XLSX"), skip=1)

# Select disease
selected_cancers <- c("Breast cancer", "Tracheal, bronchus, and lung cancer", "Colon and rectum cancer", 
                      "Prostate cancer", "Liver cancer due to hepatitis B", "Cervical cancer", 
                      "Esophageal cancer", "Pancreatic cancer", "Kidney cancer", "Stomach cancer")

# Select regions
selected_regions <- c("Central Asia", "Central Europe", "Eastern Europe", "Australasia", "Western Europe",
                      "Andean Latin America", "Caribbean", "Southern Latin America", "Central Latin America",
                      "North Africa and Middle East", "South Asia", "East Asia", "Oceania", "Southeast Asia",
                      "Central Sub-Saharan Africa", "Eastern Sub-Saharan Africa", "Southern Sub-Saharan Africa",
                      "Western Sub-Saharan Africa")

# Organize the data
long_data <- data %>%
  pivot_longer(cols = matches("\\d{4} \\(ASMR\\)"), 
               names_to = "year", values_to = "ASMR") %>%
  mutate(year = as.numeric(str_extract(year, "\\d{4}")))

# Set the colors
my_colors <- colorRampPalette(RColorBrewer::brewer.pal(8, "Set2"))(15)

saveRDS(long_data, file = here::here("output/data_clean.rds"))
