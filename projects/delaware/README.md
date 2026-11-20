# Delaware school water sampling

[Explore the districts in your browser](https://jamolovb.github.io/html-portfolio/projects/delaware/)

For ISTA 320 at the University of Arizona, Team Wellness (Rebecca Lersch, Bekhruz Jamolov, and Vanessa Rivas-Davila) analyzed Delaware school water sampling records. My main contribution was the R Shiny interface that brought our team's charts and interactive Leaflet district map together.

This portfolio edition includes a new, smaller Shiny example and a static browser explorer. Both use the same district summary. The original class dashboard included additional fixture and sample-type comparisons.

## Reproduce the summary

Download the 2023 sampling results CSV from the [Delaware Open Data dashboard](https://data.delaware.gov/stories/s/2023-Lead-in-Drinking-Water-Sampling-Results-Dashb/pc3b-a6j3). From this directory, with the R packages `readr` and `dplyr` installed, run:

```sh
Rscript prepare.R path/to/results.csv
```

The November 12, 2025 extract had 17,697 rows. Requiring district, school, fixture description, sample type, and a numeric result retained 17,667. We group by the district field as supplied, including the “Charter School” reporting group. For Colonial, the maximum across 1,360 retained samples is 5,400 ppb. Adding separate fixture-category maxima would misstate this value.

## Run the Shiny example

The map uses simplified polygons from the 2024 Census TIGER/Line unified school district boundaries supplied with the course project. Sixteen district names match the sampling extract. The other four reporting groups remain available in the selector.

With R and the `shiny`, `sf`, and `leaflet` packages installed, run `Rscript -e 'shiny::runApp(".", launch.browser = TRUE)'` from this directory. The included CSV lets the example start without downloading the raw data.
