#!/bin/sh

aws ec2 create-key-pair --region us-east-1 --key-name bastion | jq -r .KeyMaterial > temp.pem
if [ $? == 0 ]; then
  mv temp.pem bastion.pem
  chmod 600 bastion.pem
  echo 'A new key was created.'
fi
rm -f temp.pem
