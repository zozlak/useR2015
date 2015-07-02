#' @title tests behaviour of the dbReadTable() regarging tables in non-default
#'   schema
#' @description 
#' Behaviour of the dbReadTable() regaring relations in schema other the default
#' one is not described. Due to that we can only describe the way the driver
#' behaves but we can not test if it meets the DBI interface or not.
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return logical vector describing dbReadTable() behaviour
#' @import DBI
#' @import testthat
#' @export
test_dbReadTable_another_schema = function(conn){
  on.exit(tidy_up(conn))
  create_schemas(conn)
  
  results = c(unescapedName = FALSE, schemaParameter = FALSE, nameAsVector = FALSE)
  try({  
    model = data.frame(foo = 1:2, stringsAsFactors = FALSE)
    try({
      expect_equal(dbReadTable(conn, 'foo.bar'), model)
      results['unescapedName'] = TRUE
    }, silent = TRUE)
    try({
      expect_equal(dbReadTable(conn, 'bar', schema = 'foo'), model)
      results['schemaParameter'] = TRUE
    }, silent = TRUE)
    try({
      expect_equal(dbReadTable(conn, c('foo', 'bar')), model)
      results['nameAsVector'] = TRUE
    }, silent = TRUE)
  })
  return(results)
}
