Interactive Chart of Tourist Business Numbers in Castilla Leon 
========================================================
author: Pablo
date: 21-8-2014

Introduction
========================================================

This presentation is for the **Develop Data Products** Coursera course.

The objective of this project is show tourist data number from Castilla-Leon region in a interactive chart.

Data
========================================================

The data has been download from [Opendata Castilla y Leon Goverment](http://www.datosabiertos.jcyl.es/).

The data is competed and transformed to be usable for the chart. Also the categories are translate with the sub function, for example.

```r
txt <- c("CAFETERIAS","HOTELES","CAFETERIAS", "RESTAURANTES")
txt <- sub("CAFETERIAS", "CAFE", txt)
txt
```

```
[1] "CAFE"         "HOTELES"      "CAFE"         "RESTAURANTES"
```


Result
========================================================

The result is a interactive stacked column chart using the googleVis library:


```r
help(googleVis)
```


You can use the Shiny App [DevDataProd](http://pacab.shinyapps.io/DevDataProd/)

Help
========================================================

To use the application:

1. Select a type of business in Category
2. Check same provinces. If you don't check any, the number of all provinces is shown.
3. Check same month to compare.
4. Select de Map tab.
5. Push the button to show the result.
