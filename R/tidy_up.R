#' @title deletes all database objects created by create_schemas()
#' @param conn connection to the database opend using DBI::dbConnect()
#' @import DBI
#' @export
tidy_up = function(conn){
  try(dbSendQuery(conn, "DROP TABLE bar_tmp"), silent = TRUE)
  try(dbSendQuery(conn, "DROP VIEW bar_view"), silent = TRUE)
  try(dbSendQuery(conn, "DROP TABLE bar"), silent = TRUE)
  try(dbSendQuery(conn, "DROP VIEW foo.bar_view"), silent = TRUE)
  try(dbSendQuery(conn, "DROP TABLE foo.bar"), silent = TRUE)
  try(dbSendQuery(conn, "DROP SCHEMA foo"), silent = TRUE)
  return(invisible(NULL))
}
