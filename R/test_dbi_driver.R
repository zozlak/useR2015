#' @title tests a given dbi impelementation
#' @description 
#' Given a handler to the database tests capabilities of the DBI driver.
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return list describing driver capabilities - see test_...() functions
#'   description
#' @import DBI
#' @import testthat
#' @examples
#' \dontrun{
#'  system('monetdbd start monetdb')
#'  handlers = list(
#'    SQLite = dbConnect(RSQLite::SQLite(), ":memory:"),
#'    MySQL = dbConnect(RMySQL::MySQL(), dbname = 'myDb'),
#'    PostgreSQL = dbConnect(RPostgreSQL::PostgreSQL(), dbname = 'myDb'),
#'    MonetDB = dbConnect(MonetDB.R::MonetDB.R(), 'pathToMyMonetDb')
#'  )
#'  sapply(handlers, test_dbi_driver)
#' }
#' @export
test_dbi_driver = function(conn){
  result = list(
    dbGetQuery = test_dbGetQuery(conn),
    dbReadTable = test_dbReadTable(conn),
    dbReadTable_another_schema = test_dbReadTable_another_schema(conn),
    dbListTables = test_dbListTables(conn),
    dbSendQuery = test_dbSendQuery(conn)
  )
  return(result)
}
