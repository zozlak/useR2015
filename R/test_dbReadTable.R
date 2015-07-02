#' @title tests behaviour of the dbReadTable()
#' @param conn connection to the database opend using DBI::dbConnect()
#' @return TRUE or FALSE indicating test pass/fail
#' @import DBI
#' @import testthat
test_dbReadTable = function(conn){
  on.exit(tidy_up(conn))
  create_schemas(conn)

  try({  
    model = data.frame(foo = letters[1:2], stringsAsFactors = FALSE)
    expect_equal(dbReadTable(conn, 'bar'), model)
    expect_equal(dbReadTable(conn, 'bar_view'), model)
    expect_equal(dbReadTable(conn, 'bar_tmp'), model)
    
    return(TRUE)
  })
  return(FALSE)
}
