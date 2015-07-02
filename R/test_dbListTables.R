#' @title tests behaviour of the dbListTables()
#' @description 
#' As the dbListTables() specification in the DBI is simply wrong (if you want
#' to support schemas you can not return a character vector as a dbListTables()
#' result because it is impossible to correctly escape schema and table name
#' then), we can not provide a tests giving simple pass/fail results.
#' 
#' Instead of that we can only check out and describe some aspects of the
#' dbListTables() like if views are listed, if temporary tables are listed, etc.
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return numeric vector describing dbListTables() behaviour
#' @import DBI
#' @import testthat
#' @export
test_dbListTables = function(conn){
  on.exit(tidy_up(conn))
  create_schemas(conn)
  
  tables = dbListTables(conn)
  results = c(
    length = length(tables), 
    otherSchemas = any(duplicated(tables)), 
    temporary = any(tables %in% 'bar_tmp'), 
    views = any(tables %in% 'bar_view')
  )
  return(results)
}
