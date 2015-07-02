# R database connectivity: what did we leave behind?

Materials for the *R database connectivity: what did we leave behind?* talk given on the [useR! 2015 conference](http://user2015.math.aau.dk/).

## Presentation

You will find the presentation in the [vignettes](https://github.com/zozlak/useR2015/vignettes) folder and the set of DBI drivers tests is available in the [R](https://github.com/zozlak/useR2015/R) folder.

## Tests

To prepare the presentation a set of tests for DBI drivers compatibility was developed.

To enable others to simply replicate these tests they were encapsuleted into R package and published as this repository.

To install the package, please type:

```r
devtools::install_github('zozlak/useR2015')
```

Then you can use test functions e.g.:

```r
library(useR2015)
library
system('monetdbd start monetdb')
handlers = list(
  SQLite = dbConnect(RSQLite::SQLite(), ":memory:"),
  MySQL = dbConnect(RMySQL::MySQL(), dbname = 'myDb'),
  PostgreSQL = dbConnect(RPostgreSQL::PostgreSQL(), dbname = 'myDb'),
  MonetDB = dbConnect(MonetDB.R::MonetDB.R(), 'pathToMyMonetDb')
)

# test all capabilities at once
sapply(handlers, test_dbi_driver)

# test specific API call
sapply(handlers, test_dbGetQuery)
```
