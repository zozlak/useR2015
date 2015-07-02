#' @title tests dbSendQuery() compatibility
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return TRUE or FALSE indicating test pass/fail
#' @import DBI
#' @import testthat
#' @export
test_dbSendQuery = function(conn){
  on.exit(tidy_up(conn))
  create_schemas(conn)
  try({
    dbSendQuery(conn, "UPDATE bar SET foo = 'z'")
    model = data.frame(foo = c('z', 'z'), stringsAsFactors = FALSE)
    expect_equal(dbGetQuery(conn, "SELECT * FROM bar ORDER BY 1"), model)

    dbSendQuery(conn, "INSERT INTO bar VALUES ('x')")
    model = data.frame(foo = c('x', 'z', 'z'), stringsAsFactors = FALSE)
    expect_equal(dbGetQuery(conn, "SELECT * FROM bar ORDER BY 1"), model)

    dbSendQuery(conn, "CREATE OR REPLACE VIEW bar_view AS SELECT * FROM bar")

    # check if dbSendQuery will free unreaded results
    dbSendQuery(conn, "SELECT * FROM bar")
    dbSendQuery(conn, "UPDATE bar SET foo = 'z'")

    return(TRUE)
  })
  return(FALSE)
}
