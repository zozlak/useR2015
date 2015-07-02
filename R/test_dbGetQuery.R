#' @title tests dbGetQuery() compatibility
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return TRUE or FALSE indicating test pass/fail
#' @import DBI
#' @import testthat
test_dbGetQuery = function(conn){
  on.exit(tidy_up(conn))
  create_schemas(conn)
  try({
    model = data.frame(foo = letters[1:2], stringsAsFactors = FALSE)
    expect_equal(dbGetQuery(conn, "SELECT * FROM bar ORDER BY 1"), model)
    expect_equal(dbGetQuery(conn, "SELECT * FROM bar_view ORDER BY 1"), model)
    expect_equal(dbGetQuery(conn, "SELECT * FROM bar_tmp ORDER BY 1"), model)
    
    model = data.frame(foo = 1:2, stringsAsFactors = FALSE)
    expect_equal(dbGetQuery(conn, "SELECT * FROM foo.bar ORDER BY 1"), model)
    expect_equal(dbGetQuery(conn, "SELECT * FROM foo.bar_view ORDER BY 1"), model)

    return(TRUE)
  })
  return(FALSE)
}
