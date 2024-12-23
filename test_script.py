from awsglue.dynamicframe import DynamicFrame
from awsglue.transforms import Join
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from Database import *

# Create Spark & Glue context
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

spark.conf.set("spark.sql.debug.maxToStringFields", 1000)

DATABASE = "redshift_prod_ci"
OUTPUT_PATH = "s3://aws-glue-assets-798181955907-eu-central-1"

# ## create dynamic frames from data catalog (not supported in local development)
# test: DynamicFrame = glueContext.create_dynamic_frame.from_catalog(
# database=DATABASE, table_name="production_dw_consensus_indicator_dashboard").show()

#try with cursur
import boto3 
import json
import os
import pg8000 as pg
import parameters as pm
import pandas as pd

s3_config_bucket = 'inrev-project-data-warehouse-test'
s3_config_dir = 'Glue/projects/investment_intentions/configs/config_{0}.json'.format('INREV')

redshift = Redshift_Operator()
s3 = S3_Operator()

query = """
        select 
        distinct conv.record_id, 
                 conv.survey_code_id, 
                 conv.record_currency_id,
                 CAST(conv.xr_value_numeric as float) as global_value_asset, 
                 cou.region, resp.investor_type, al.answer_label
             from dw_survey_ii.current_allocation ca
                join dw_survey_ii.target_allocation ta on ta.record_id = ca.record_id
                join dw_survey_ii.fv_converted_responses conv on conv.record_id = ta.record_id 
                join dw_survey_ii.dv_country cou on cou.id = conv.country_id
                join dw_survey_ii.dv_answer_label al on al.id = conv.answer_label_id
                join dw_survey_ii.dv_company comp on comp.id = conv.company_id
                join dw_survey_ii.dv_currency_to ct on conv.to_currency_id = ct.id
                join dw_survey_ii.dv_survey_code scode on conv.survey_code_id = scode.id
                join dw_survey_ii.dv_responder resp on resp.record_id = conv.record_id
            where 
              	al.answer_label in ('ValueGlobalAssets_AllAssetClasses', 'ValueGlobalAssets_TotalRealEstate') 
              	and resp.survey_version = 'II'
       limit 10
       """

s3_content = s3.read_json_s3(s3_config_bucket, s3_config_dir)
redshift_content = redshift.read_data(query, "testing.csv")

#s3.upload_file_s3("testing.csv", s3_config_bucket, "testing/testing.csv")

#Tested:
# Can read from S3, Can read from Redshift, can push to s3
