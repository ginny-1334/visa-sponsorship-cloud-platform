test-s3-glue-job:
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# RDS connection URL
JDBC_URL = "jdbc:postgresql://visa-group1-postgres.clyiuasiev48.us-east-1.rds.amazonaws.com:5432/visa_analytics"
JDBC_PROPS = {
    "user": "postgres",
    "password": "postgres",
    "driver": "org.postgresql.Driver"
}

# ── H1B: S3 processed → RDS h1b_sponsors ──
h1b_df = spark.read.parquet("s3://visa-processed-data/h1b_clean/")

h1b_df.write \
    .format("jdbc") \
    .option("url", JDBC_URL) \
    .option("dbtable", "h1b_sponsors") \
    .option("user", JDBC_PROPS["user"]) \
    .option("password", JDBC_PROPS["password"]) \
    .option("driver", JDBC_PROPS["driver"]) \
    .mode("overwrite") \
    .save()

print("H1B loaded successfully")

# ── PERM: S3 processed → RDS perm_records ──
perm_df = spark.read.parquet("s3://visa-processed-data/perm_clean/")

perm_df.write \
    .format("jdbc") \
    .option("url", JDBC_URL) \
    .option("dbtable", "perm_records") \
    .option("user", JDBC_PROPS["user"]) \
    .option("password", JDBC_PROPS["password"]) \
    .option("driver", JDBC_PROPS["driver"]) \
    .mode("overwrite") \
    .save()

print("PERM loaded successfully")

job.commit()

