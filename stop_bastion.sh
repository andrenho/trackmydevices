#!/bin/sh

INSTANCE=$(aws ec2 describe-instances --filters Name=tag:Name,Values=bastion | jq -r .Reservations[0].Instances[0].InstanceId)
aws ec2 stop-instances --instance-ids $INSTANCE

echo 'Bastion stopped.'
