#!/bin/sh

./update_function.sh --publish
VERSION=$(aws lambda list-versions-by-function --function-name database_api | jq -r .Versions[].Version | egrep '[[:digit:]]+' | sort -g | tail -n1)
echo "Setting version ${VERSION} to prod."
aws lambda update-alias --function-name database_api --name prod --function-version ${VERSION}
