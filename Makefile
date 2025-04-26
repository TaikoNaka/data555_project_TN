.PHONY: all
## all: Run the full pipeline (data load, chart, plot, and report)
all: render_report

## output/clean_data.rds: Cleaned data loaded from source
output/data_clean.rds: code/00_load_data.R data/raw_data.csv
	Rscript code/00_load_data.R

## output/chart_summary.rds: Table/chart summary output
output/line_chart.rds: code/01_make_chart.R output/clean_data.rds
	Rscript code/01_make_chart.R

## output/plot.png: Visualization plot generated from data
output/plot.png: code/02_make_plot.R output/clean_data.rds
	Rscript code/02_make_plot.R

## report.html: Final rendered report
report.html: code/03_render_report.R \
  report_template.Rmd output/chart_summary.rds output/plot.png
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
render_report: report.html

.PHONY: clean
## clean: Remove all generated output files
clean:
	rm -f output/*.rds output/*.png report.html

.PHONY: help
## help: Show help for each target
help: Makefile
	@sed -n 's/^##//p' Makefile
