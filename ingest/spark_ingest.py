from pyspark.sql import SparkSession
import yaml

# Load database connection parameters from a YAML file
def load_db_config(config_path):
    with open(config_path, 'r') as file:
        return yaml.safe_load(file)

db_config_path = '/home/sid/Desktop/copilot/ingest/params.yaml'  # Path to the YAML config file
db_params = load_db_config(db_config_path)['spark']
db_user = db_params['user']
db_password = db_params['password']
db_driver = db_params['driver']
db_database = db_params['database']

# Create a Spark session
spark = SparkSession.builder.master("local[1]").appName("PostgreSQL").config("spark.jars","/home/sid/Desktop/copilot/postgresql-42.7.3.jar").getOrCreate()

# Read the CSV file into a DataFrame
df = spark.read.csv("/home/sid/Desktop/copilot/data/customers.csv", header=True, inferSchema=True)

# Configure the PostgreSQL connection properties
properties = {
    "user": db_user,
    "password": db_password,
    "driver": db_driver
}

# Write the DataFrame to the PostgreSQL table
df.write.jdbc(url=f"jdbc:postgresql://localhost:5432/{db_database}",
              table="landing_customers",
              mode="overwrite",
              properties=properties)


# Read the CSV file into a DataFrame
df = spark.read.csv("/home/sid/Desktop/copilot/data/products.csv", header=True, inferSchema=True)

# Configure the PostgreSQL connection properties
properties = {
    "user": db_user,
    "password": db_password,
    "driver": db_driver
}

# Write the DataFrame to the PostgreSQL table
df.write.jdbc(url=f"jdbc:postgresql://localhost:5432/{db_database}",
              table="landing_products",
              mode="overwrite",
              properties=properties)


# Read the CSV file into a DataFrame
df = spark.read.csv("/home/sid/Desktop/copilot/data/sales.csv", header=True, inferSchema=True)

# Configure the PostgreSQL connection properties
properties = {
    "user": db_user,
    "password": db_password,
    "driver": db_driver
}

# Write the DataFrame to the PostgreSQL table
df.write.jdbc(url=f"jdbc:postgresql://localhost:5432/{db_database}",
              table="landing_sales",
              mode="overwrite",
              properties=properties)

# Stop the Spark session
spark.stop()


