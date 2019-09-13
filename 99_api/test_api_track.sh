#!/bin/sh

API_ID=$(aws apigateway get-rest-apis | jq -r '.items[] | select(.name == "trackmd") | .id')
RESOURCE_ID=$(aws apigateway get-resources --rest-api-id ${API_ID} | jq -r '.items[] | select(.path == "/track/{device_id}") | .id')

aws apigateway test-invoke-method \
        --rest-api-id ${API_ID} \
        --resource-id ${RESOURCE_ID} \
        --http-method GET \
        --path-with-query-string '/track/35b8f3f4-eb8b-48ab-82af-3a4e51962017' > temp.txt
cat temp.txt | jq -r .log
cat temp.txt | jq 'del(.log) | del(.body)'
echo '---------------------------------------'
cat temp.txt | jq -r .body | jq
rm temp.txt
