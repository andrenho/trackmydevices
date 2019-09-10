#!/bin/sh

./update_function.sh --publish
VERSION=$(aws lambda list-versions-by-function --function-name database_api --query "max_by(Versions, &Version).{Version:Version}" | jq -r .Version)
aws lambda update-alias --function-name database_api --name prod --function-version ${VERSION}
