#!/bin/sh

aws lambda invoke --function-name database_api --payload '{ "pathParameters": { "username": "andre_nho" } }' --log-type Tail outfile | jq
cat outfile | jq
rm outfile
