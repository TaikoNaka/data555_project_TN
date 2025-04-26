here::i_am("code/01_make_chart.R")

long_data <- readRDS(file = here::here("output/data_clean.rds"))

library(plotly)
library(stringr)

# Global Cancer Mortality Trends 
trend_data <- long_data %>% 
  filter(location_name == "Global", cause_name %in% selected_cancers)

trend_data <- trend_data %>%
  mutate(ASMR = as.numeric(str_extract(ASMR, "^[0-9\\.]+")))


# Interactive Plotly Line Chart
line_chart <- plot_ly(trend_data, x = ~year, y = ~ASMR, color = ~cause_name, colors = my_colors, type = 'scatter', mode = 'lines+markers',
          hoverinfo = 'text',
          text = ~paste('Cancer Type:', cause_name, '<br>Year:', year, '<br>ASMR:', round(ASMR,2), '(per 100,000)')) %>%
       layout(title = "Global Cancer Mortality Rates Over Time (1990-2021)",
           xaxis = list(title = "Year"),
           yaxis = list(title = "Age-Standardized Mortality Rate (per 100,000)"),
           legend = list(title=list(text='Cancer Type')))

saveRDS(line_chart, file = here::here("output/line_chart.rds"))

