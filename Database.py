import boto3 
import json
import os
import pg8000 as pg
import pandas as pd

class S3_Operator:
    def __init__(self) -> None:
        self.region_name = 'eu-central-1'
        self.conn = boto3.client('s3', self.region_name)
    
    def read_json_s3(self, s3_config_bucket, s3_dir):
        content_s3_object = self.conn.get_object(Bucket = s3_config_bucket, Key = s3_dir)
        file_content = content_s3_object['Body']
        json_content = json.load(file_content)
        return json_content
    
    def upload_file_s3(self, target_file, s3_config_bucket, s3_target):
        self.conn.upload_file(target_file, s3_config_bucket, s3_target)

    
class Redshift_Operator:
    def __init__(self):
        self.database=os.getenv('REDSHIFT_DBNAME'), 
        self.user=os.getenv('REDSHIFT_USER'), 
        self.password=os.getenv('REDSHIFT_PASSWORD'),
        self.host=os.getenv('REDSHIFT_HOST'),
        self.port=5439
        self.conn = pg.connect (
                        database=self.database[0],
                        user=self.user[0], 
                        password=self.password[0],
                        host=self.host[0],
                        port=self.port
                        )
    
    def read_data(self, querystring, csv_filename=None):
        df = pd.read_sql_query(querystring, self.conn)

        if df is not None:
            print(df)

        if csv_filename:
            df.to_csv(csv_filename)
        return df
