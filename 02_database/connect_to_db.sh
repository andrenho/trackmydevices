#!/bin/sh

PGPASSWORD=$(aws ssm get-parameter --region us-east-1 --name db_password --with-decryption --output json | jq -r .Parameter.Value) \
        psql postgresql://tmd:${PGPASSWORD}@db.tmd.gamesmith.co.uk
