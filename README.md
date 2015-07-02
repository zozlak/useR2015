# R database connectivity: what did we leave behind?

Materials for the *R database connectivity: what did we leave behind?* talk given on the [useR! 2015 conference](http://user2015.math.aau.dk/).

You will find the presentation in the [vignettes](https://github.com/zozlak/useR2015/vignettes) folder and the set of DBI drivers tests is available in the [R](https://github.com/zozlak/useR2015/R) folder.

Repository itself is an R package, so you can install it using

```r
devtools::install_github('zozlak/useR2015')
```

and then simply use test functions (like *test_dbGetQuery()*, etc.), e.g.:

```r
system('monetdbd start monetdb')
handlers = list(
  SQLite = dbConnect(RSQLite::SQLite(), ":memory:"),
  MySQL = dbConnect(RMySQL::MySQL(), dbname = 'myDb'),
  PostgreSQL = dbConnect(RPostgreSQL::PostgreSQL(), dbname = 'myDb'),
  MonetDB = dbConnect(MonetDB.R::MonetDB.R(), 'pathToMyMonetDb')
)
sapply(handlers, test_dbi_driver)
```
