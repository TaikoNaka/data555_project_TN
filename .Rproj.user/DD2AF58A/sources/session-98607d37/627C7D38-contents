.PHONY: all
## all: Run the full pipeline (data load, chart, plot, and report)
all: render_report

## output/clean_data.rds: Cleaned data loaded from source
output/clean_data.rds: code/00_load_data.R raw_data/IHME_GBD_2021_MORTALITY.xlsx
	Rscript code/00_load_data.R

## output/chart_summary.rds: Table/chart summary output
output/line_chart.rds: code/01_make_chart.R output/clean_data.rds
	Rscript code/01_make_chart.R

## output/plot.png: Visualization plot generated from data
output/plot.png: code/02_make_plot.R output/clean_data.rds
	Rscript code/02_make_plot.R

## global_cancer_dashboard.html: Final rendered flexdashboard
global_cancer_dashboard.html: code/03_render_report.R \
  global_cancer_dashboard.Rmd output/line_chart.rds output/plot.png
	Rscript code/03_render_report.R

.PHONY: load_data
## load_data: Only run the data loading/cleaning step
load_data: output/clean_data.rds

.PHONY: make_chart
## make_chart: Only generate the chart/table summary
make_chart: output/chart_summary.rds

.PHONY: make_plot
## make_plot: Only generate the plot
make_plot: output/plot.png

.PHONY: render_report
## render_report: Only render the final report
render_report: global_cancer_dashboard.html

.PHONY: clean
## clean: Remove all generated output files
clean:
	rm -f output/*.rds output/*.png *.html

.PHONY: help
## help: Show help for each target
help: Makefile
	@sed -n 's/^##//p' Makefile
