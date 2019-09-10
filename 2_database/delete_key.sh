#!/bin/sh

rm -f bastion.pem
aws ec2 delete-key-pair --region us-east-1 --key-name bastion
