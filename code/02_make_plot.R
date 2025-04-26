here::i_am("code/02_make_plot.R")

long_data <- readRDS(file = here::here("output/data_clean.rds"))

library(plotly)

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
