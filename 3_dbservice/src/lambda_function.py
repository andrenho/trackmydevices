import boto3
import json
import psycopg2

db_name = 'tmd'
db_user = 'tmd'
db_host = 'db.tmd.gamesmith.co.uk'

def lambda_handler(event, lambda_context):
    username = event['pathParameters']['username']
    password = boto3.client('ssm').get_parameter(Name='db_password', WithDecryption=True)['Parameter']['Value']
    conn = psycopg2.connect("dbname='%s' user='%s' host='%s' password='%s'" % (db_name, db_user, db_host, password))
    
    items = []
    try:
        cursor = conn.cursor()
        cursor.execute('SELECT device, device_name FROM tmd.tmd WHERE username = %s', (username,))
        for row in cursor.fetchall():
            items.append({ 'device' : row[0], 'device_name' : row[1] })
        cursor.close()
    finally:
        conn.close()

    return {
        'statusCode': 200,
        'body': json.dumps(items)
    }
