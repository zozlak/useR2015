#' @title creates database objects required for testing
#' @param conn connection to the database opend using DBI::dbConnect()
#' @import DBI
#' @export
create_schemas = function(conn){
  try(dbSendQuery(conn, "CREATE SCHEMA foo"), silent = TRUE)
  
  try(dbSendQuery(conn, "CREATE TABLE bar (foo varchar(255))"), silent = TRUE)
  try(dbSendQuery(conn, "CREATE TABLE foo.bar (foo int)"), silent = TRUE)
  
  try(dbSendQuery(conn, "CREATE VIEW bar_view AS SELECT * FROM bar"), silent = TRUE)
  try(dbSendQuery(conn, "CREATE VIEW foo.bar_view AS SELECT * FROM foo.bar"), silent = TRUE)
  
  try(dbSendQuery(conn, "INSERT INTO bar VALUES ('a'), ('b')"), silent = TRUE)
  try(dbSendQuery(conn, "INSERT INTO foo.bar VALUES (1), (2)"), silent = TRUE)
  try(dbSendQuery(conn, "INSERT INTO bar_tmp VALUES (true), (false)"), silent = TRUE)
  
  try(dbSendQuery(conn, "CREATE TEMPORARY TABLE bar_tmp AS SELECT * FROM bar"), silent = TRUE)
}
