import os

# Print out the environment variables to check if they are set correctly
"""
print("INSTANCE_CONNECTION_NAME:", os.getenv("INSTANCE_CONNECTION_NAME"))
print("DB_USER:", os.getenv("DB_USER"))
print("DB_PASS:", os.getenv("DB_PASS"))
print("DB_NAME:", os.getenv("DB_NAME"))

$env:INSTANCE_CONNECTION_NAME = "fourth-carport-424918-a5:us-west1:csc370-national-parks"
$env:DB_USER = "Nolan"
$env:DB_PASS = ",6TO7/'-34K\oRX2"
$env:DB_NAME = "National-Parks"
S
# Verify that the variables are set
Write-Output $env:INSTANCE_CONNECTION_NAME
Write-Output $env:DB_USER
Write-Output $env:DB_PASS
Write-Output $env:DB_NAME
"""
from google.cloud.sql.connector import Connector, IPTypes
import pymysql
import sqlalchemy
from sqlalchemy import text

def connect_with_connector() -> sqlalchemy.engine.base.Engine:
    """
    Initializes a connection pool for a Cloud SQL instance of MySQL.
    Uses the Cloud SQL Python Connector package.
    """
    # Fetching environment variables
    instance_connection_name = os.environ["INSTANCE_CONNECTION_NAME"]  # e.g. 'project:region:instance'
    db_user = os.environ["DB_USER"]  # e.g. 'my-db-user'
    db_pass = os.environ["DB_PASS"]  # e.g. 'my-db-password'
    db_name = os.environ["DB_NAME"]  # e.g. 'my-database'

    ip_type = IPTypes.PRIVATE if os.environ.get("PRIVATE_IP") else IPTypes.PUBLIC

    connector = Connector(ip_type)

    def getconn() -> pymysql.connections.Connection:
        conn: pymysql.connections.Connection = connector.connect(
            instance_connection_name,
            "pymysql",
            user=db_user,
            password=db_pass,
            db=db_name,
        )
        return conn

    pool = sqlalchemy.create_engine(
        "mysql+pymysql://",
        creator=getconn,
    )
    return pool

# Function to run a sample query
def run_sample_query():
    # Connect to the database
    engine = connect_with_connector()

    # Define the query
    query = text("SELECT * FROM Users")

    # Execute the query
    with engine.connect() as connection:
        result = connection.execute(query)

        # Fetch and print the results
        for row in result:
            print(row)

if __name__ == "__main__":
    run_sample_query()