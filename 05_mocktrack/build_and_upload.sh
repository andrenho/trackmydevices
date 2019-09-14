#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "Usage: $0 VERSION_LABEL"
fi

cd mocktrack
gradle bootJar
cd ..
aws s3 cp mocktrack/build/libs/mocktrack-0.0.1-SNAPSHOT.jar s3://tmd-deploy/
aws elasticbeanstalk create-application-version --application-name mocktrail --version-label $1 --source-bundle S3Bucket="tmd-deploy",S3Key="mocktrack-0.0.1-SNAPSHOT.jar"
aws elasticbeanstalk update-environment --application-name mocktrail --environment-name mocktrail --version-label $1

# TODO - upload to eb
