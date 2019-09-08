#!/bin/sh

yum install postgresql -y
yum install jq -y
/tmp/initialize_database.sh

PGPASSWORD=$(aws ssm get-parameter --region us-east-1 --name db_password --with-decryption | jq -r .Parameter.Value)
psql postgresql://tmd:${PGPASSWORD}@db.tmd.gamesmith.co.uk <<EOF

CREATE SCHEMA tmd;

CREATE TABLE tmd.tmd (
  username VARCHAR(50) NOT NULL,
  device   VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY(username, device)
);

EOF
