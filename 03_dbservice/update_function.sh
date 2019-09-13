#!/bin/sh

rm -f deploy.zip && \
(cd src/ && zip -r ../deploy.zip .) && \
aws lambda update-function-code --function-name database_api --zip-file fileb://deploy.zip $@ &&
rm deploy.zip
