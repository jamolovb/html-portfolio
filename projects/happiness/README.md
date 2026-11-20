# Exploring Global Happiness

Our ISTA 321 team studied associations between national life-evaluation scores and six social and economic indicators in the 2023 World Happiness Report.

**My contribution** was importing and exploring the data in R, checking missing values, calculating descriptive statistics, and visualizing distributions. My teammate Osaid handled the regression analysis and model evaluation.

The input contained 137 countries and 19 columns. One row had missing values, leaving 136 complete records. I used the complete cases for the exploratory comparisons. These scores describe countries in the report; a relationship across countries does not establish a cause for individual happiness.

Across the 136 complete rows, the median ladder score was **5.694** and the observed range was **1.859 to 7.804** on the 0–10 scale.

## Reproduce the exploratory analysis

With the course dataset `MidtermData.csv`, run:

```sh
Rscript explore.R MidtermData.csv
```

The script prints sample size and score summaries and writes a histogram to `happiness-scores.pdf`. [World Happiness Report 2023](https://worldhappiness.report/ed/2023/)
