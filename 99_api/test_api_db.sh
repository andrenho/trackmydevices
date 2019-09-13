#!/bin/sh

API_ID=$(aws apigateway get-rest-apis | jq -r '.items[] | select(.name == "trackmd") | .id')
RESOURCE_ID=$(aws apigateway get-resources --rest-api-id ${API_ID} | jq -r '.items[] | select(.path == "/user/{username}") | .id')

aws apigateway test-invoke-method \
        --rest-api-id ${API_ID} \
        --resource-id ${RESOURCE_ID} \
        --http-method GET \
        --path-with-query-string '/user/andre_nho' > temp.txt
cat temp.txt | jq -r .log
cat temp.txt | jq 'del(.log) | del(.body)'
echo '---------------------------------------'
cat temp.txt | jq -r .body | jq
rm temp.txt
