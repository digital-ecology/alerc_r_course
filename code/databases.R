

# load libraries ----------------------------------------------------------
library(DBI)


# connect to the database -------------------------------------------------

mydb <- dbConnect(RSQLite::SQLite(), "data/records.sqlite")

dbListTables(mydb) # lists the tables in the database
dbListFields(mydb, "records") # lists the fields in a table


# write queries -----------------------------------------------------------

dbGetQuery(mydb, 'SELECT * FROM records LIMIT 5')

df <- dbGetQuery(mydb, "SELECT id, common_name, latin_name, year, grid_ref FROM records WHERE year > 2020") # create a dataframe for further processing


# disconnect from database ------------------------------------------------
# it is important that you do this at the end of the session

dbDisconnect(mydb)

# creating database connections -------------------------------------------
# you will need to know your database credentials
con <- DBI::dbConnect(odbc::odbc(),
                      Driver    = "SQL Server", 
                      Server    = [My Server],
                      Database  = [My Database],
                      UID       = [My User ID],
                      PWD       = [My Password],
                      Port      = 1433)

