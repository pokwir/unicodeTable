## \# UnicodeTable

Provides a way to print dataframes and tibbles as formatted Unicode tables with rounded corners and box-drawing characters.

### **1. Why Bother?**

Because: - the `ascii` table is boring and complicated if you just want to print my stuff in plain text - the default R table view is great in notebooks, not the best in terminals - i like to have fun creating new stuff I can reuse.

### **2. How to use**

1.  You will have to first install it using dev tools

``` r
devtools::install_github("pokwir/UnicodeTable")
```

2.  Define some data. In this case something that looks like this as your df. The `sep_line`, `sep_score`, and `sep_total` used in this example is actually part of the data (becuase I want to have fun with it). You can pass any df object you like.

``` r
 sep_line <- "──────────────────────────"
 sep_score <- "─────────"
 sep_total <- "──────────"

 data <- data.frame(
    `Metric Assessed` = c(
      "Statistical methodology", 
      "Replicability", 
      "Conclusions", 
      "Presentation", 
      "Citations",
      sep_line,          
      "Overall",
      sep_line    
    ),
    `Score` = c("17", "5", "5", "3", "2", sep_score, "32", sep_score),
    `Total Marks` = c("20", "5", "5", "5", "5", sep_total, "40", sep_total),
    check.names = FALSE
 )
```

3.  Print <br>

3.1 Print with defult behaviour (adds index column to the dataframe). `addRowNames = TRUE` is the default behavior

``` r
unicodeTable(data)
```

``` scss
╭───┬────────────────────────────┬───────────┬─────────────╮ 
│   │ Metric Assessed            │ Score     │ Total Marks │ 
├───┼────────────────────────────┼───────────┼─────────────┤ 
│ 0 │ Statistical methodology    │ 17        │ 20          │ 
│ 1 │ Replicability              │ 5         │ 5           │ 
│ 2 │ Conclusions                │ 5         │ 5           │ 
│ 3 │ Presentation               │ 3         │ 5           │ 
│ 4 │ Citations                  │ 2         │ 5           │ 
│ 5 │────────────────────────────│───────────│─────────────│ 
│ 6 │ Overall                    │ 32        │ 40          │ 
│ 7 │────────────────────────────│───────────│─────────────│ 
╰───┴────────────────────────────┴───────────┴─────────────╯ 
```

<br>

3.2 Print without adding index

``` r
unicodeTable(data addRowNames = FALSE)
```

``` scss
╭────────────────────────────┬───────────┬─────────────╮ 
│ Metric Assessed            │ Score     │ Total Marks │ 
├────────────────────────────┼───────────┼─────────────┤ 
│ Statistical methodology    │ 17        │ 20          │ 
│ Replicability              │ 5         │ 5           │ 
│ Conclusions                │ 5         │ 5           │ 
│ Presentation               │ 3         │ 5           │ 
│ Citations                  │ 2         │ 5           │ 
│────────────────────────────│───────────│─────────────│ 
│ Overall                    │ 32        │ 40          │ 
│────────────────────────────│───────────│─────────────│ 
╰────────────────────────────┴───────────┴─────────────╯ 
```

<br>

**Current Version** Version: 0.1.0

**Enjoy**
