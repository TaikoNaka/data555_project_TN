---
  title: "Global Trends and Distribution of Cancer Mortality"
output: 
  flexdashboard::flex_dashboard:
  orientation: column
vertical_layout: fill
---
  
```{r, include=FALSE}
library(flexdashboard)
library(tidyverse)
library(plotly)
library(readxl)

# Load data 
data <- read_excel("IHME_GBD_2021_MORTALITY.xlsx", skip = 1)

# select disease
selected_cancers <- c("Breast cancer", "Tracheal, bronchus, and lung cancer", "Colon and rectum cancer", 
                      "Prostate cancer", "Liver cancer due to hepatitis B", "Cervical cancer", 
                      "Esophageal cancer", "Pancreatic cancer", "Kidney cancer", "Stomach cancer")

# select regions
selected_regions <- c("Central Asia", "Central Europe", "Eastern Europe", "Australasia", "Western Europe",
                      "Andean Latin America", "Caribbean", "Southern Latin America", "Central Latin America",
                      "North Africa and Middle East", "South Asia", "East Asia", "Oceania", "Southeast Asia",
                      "Central Sub-Saharan Africa", "Eastern Sub-Saharan Africa", "Southern Sub-Saharan Africa",
                      "Western Sub-Saharan Africa")

# organize the data
long_data <- data %>%
  pivot_longer(cols = matches("\\d{4} \\(ASMR\\)"), 
               names_to = "year", values_to = "ASMR") %>%
  mutate(year = as.numeric(str_extract(year, "\\d{4}")))

my_colors <- colorRampPalette(RColorBrewer::brewer.pal(8, "Set2"))(15)
```


# Global Cancer Mortality Trends (1990-2021)

column {data-width=750}
-------------------------------------
  
  ### Global Mortality Trends by Cancer Type
  
  ```{r}
# Global Cancer Mortality Trends 
trend_data <- long_data %>% 
  filter(location_name == "Global", cause_name %in% selected_cancers)

trend_data <- trend_data %>%
  mutate(ASMR = as.numeric(str_extract(ASMR, "^[0-9\\.]+")))


# Interactive Plotly Line Chart
plot_ly(trend_data, x = ~year, y = ~ASMR, color = ~cause_name, colors = my_colors, type = 'scatter', mode = 'lines+markers',
        hoverinfo = 'text',
        text = ~paste('Cancer Type:', cause_name, '<br>Year:', year, '<br>ASMR:', round(ASMR,2), '(per 100,000)')) %>%
  layout(title = "Global Cancer Mortality Rates Over Time (1990-2021)",
         xaxis = list(title = "Year"),
         yaxis = list(title = "Age-Standardized Mortality Rate (per 100,000)"),
         legend = list(title=list(text='Cancer Type')))
```

column {data-width=250}
-------------------------------------
  
  ### Key points
  
  - Mortality rates have declined over time for most cancer types.
- Mortality rates have increased slightly for pancreatic cancer from 1990 to 2020. 
- For stomac cancer, mortality rates halved from 1990 to 2020.


# Regional Cancer Mortality Distribution (2021)

column {data-width=750}
-------------------------------------
  
  ### Regional Distribution of Cancer Mortality (2021)
  
  ```{r}
# 2021 data by reagion
distribution_data <- long_data %>%
  filter(location_name %in% selected_regions, cause_name %in% selected_cancers, year == 2021)

# Plot
distribution_data <- distribution_data %>%
  mutate(ASMR = str_trim(ASMR), 
         ASMR = as.numeric(str_extract(ASMR, "^[0-9\\.]+")))

plot_ly(distribution_data, x = ~cause_name, y = ~ASMR, color = ~location_name,
        colors = my_colors,
        type = 'box',
        hoverinfo = 'text',
        text = ~paste('Region:', location_name, '<br>Region:', cause_name, '<br>ASMR:', round(ASMR,2), '(per 100,000)')) %>%
  layout(title = "Regional Cancer Mortality Distribution (2021)",
         xaxis = list(title = "Cancer Type", tickangle = -45),
         yaxis = list(title = "Age-Standardized Mortality Rate (per 100,000)"))
```

column {data-width=250}
-------------------------------------
  
  ### Key points
  
  - Differences in mortality rates by region vary widely by type of cancer.
- Tracheal, bronchus, and lung cancers have very large regional differences in mortality. 
- Renal and liver cancers have low overall mortality rates and relatively few regional differences.
