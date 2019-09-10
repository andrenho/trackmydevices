import boto3
import psycopg2

db_name = 'tmd'
db_user = 'tmd'
db_host = 'db.tmd.gamesmith.co.uk'

def lambda_handler(event, lambda_context):
    print(event)
    print(lambda_context)
    password = boto3.client('ssm').get_parameter(Name='db_password', WithDecryption=True)['Parameter']['Value']
    conn = psycopg2.connect("dbname='%s' user='%s' host='%s' password='%s'" % (db_name, db_user, db_host, password))
    return password
