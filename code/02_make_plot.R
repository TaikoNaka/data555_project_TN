here::i_am("code/02_make_plot.R")

long_data <- readRDS(file = here::here("output/clean_data.rds"))

selected_regions <- c("Central Asia", "Central Europe", "Eastern Europe", "Australasia", "Western Europe",
                      "Andean Latin America", "Caribbean", "Southern Latin America", "Central Latin America",
                      "North Africa and Middle East", "South Asia", "East Asia", "Oceania", "Southeast Asia",
                      "Central Sub-Saharan Africa", "Eastern Sub-Saharan Africa", "Southern Sub-Saharan Africa",
                      "Western Sub-Saharan Africa")

selected_cancers <- c("Breast cancer", "Tracheal, bronchus, and lung cancer", "Colon and rectum cancer", 
                      "Prostate cancer", "Liver cancer due to hepatitis B", "Cervical cancer", 
                      "Esophageal cancer", "Pancreatic cancer", "Kidney cancer", "Stomach cancer")

my_colors <- colorRampPalette(RColorBrewer::brewer.pal(8, "Set2"))(15)

library(plotly)
library(stringr)

# 2021 data by reagion
distribution_data <- long_data %>%
  filter(location_name %in% selected_regions, cause_name %in% selected_cancers, year == 2021)

# Plot
distribution_data <- distribution_data %>%
  mutate(ASMR = str_trim(ASMR), 
         ASMR = as.numeric(str_extract(ASMR, "^[0-9\\.]+")))

plot <- plot_ly(distribution_data, x = ~cause_name, y = ~ASMR, color = ~location_name,
          colors = my_colors,
          type = 'box',
          hoverinfo = 'text',
          text = ~paste('Region:', location_name, '<br>Region:', cause_name, '<br>ASMR:', round(ASMR,2), '(per 100,000)')) %>%
        layout(title = "Regional Cancer Mortality Distribution (2021)",
          xaxis = list(title = "Cancer Type", tickangle = -45),
          yaxis = list(title = "Age-Standardized Mortality Rate (per 100,000)"))

saveRDS(plot, file = here::here("output/plot.rds"))
