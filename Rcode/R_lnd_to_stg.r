# Load necessary libraries
library(RPostgres)
library(dplyr)

# Define the file path for the CSV file
csv_file_path <- "path/to/your/data.csv"

# Extract: Read data from the CSV file
data <- read.csv(csv_file_path)

# Transform: Clean and transform the data
# Here, we'll just do some basic transformations for the example
# Convert column names to lower case
data <- data %>%
  rename_all(tolower)

# Define PostgreSQL connection parameters
db_host <- "your_db_host"
db_port <- 5432
db_name <- "your_db_name"
db_user <- "your_db_user"
db_password <- "your_db_password"

# Establish a connection to the PostgreSQL database
con <- dbConnect(
  RPostgres::Postgres(),
  host = db_host,
  port = db_port,
  dbname = db_name,
  user = db_user,
  password = db_password
)

# Define the staging table name
staging_table <- "staging_table_name"

# Load data into the staging table
dbWriteTable(con, staging_table, data, overwrite = TRUE, row.names = FALSE)

# Close the database connection
dbDisconnect(con)