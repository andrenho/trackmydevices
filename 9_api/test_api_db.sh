#!/bin/sh

aws apigateway test-invoke-method \
        --rest-api-id uap94dftek \
        --resource-id brid59 \
        --http-method GET \
        --path-with-query-string '/track/35b8f3f4-eb8b-48ab-82af-3a4e51962017' > temp.txt
cat temp.txt | jq -r .log
cat temp.txt | jq 'del(.log)'
rm temp.txt
