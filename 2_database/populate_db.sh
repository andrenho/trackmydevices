#!/bin/sh

PGPASSWORD=$(aws ssm get-parameter --region us-east-1 --name db_password --with-decryption --output json | jq -r .Parameter.Value)
psql postgresql://tmd:${PGPASSWORD}@db.tmd.gamesmith.co.uk <<EOF

CREATE SCHEMA tmd;

CREATE TABLE tmd.tmd (
  username    VARCHAR(50) NOT NULL,
  device      VARCHAR(50) UNIQUE NOT NULL,
  device_name VARCHAR(50),
  PRIMARY KEY(username, device)
);

-- test insert
INSERT INTO tmd.tmd (username, device, device_name) VALUES ('andre_nho', '49b8a296-3bc5-42db-ae
00-6d97329e919b', 'My test device');

EOF
