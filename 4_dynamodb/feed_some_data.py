#!/usr/bin/env python3

device_id = '49b8a296-3bc5-42db-ae00-6d97329e919b'
points = [
      [ -47.213841676712036, -23.07773798697002 ],
      [ -47.21551537513732, -23.077728116720863 ],
      [ -47.217124700546265, -23.078053834561214 ],
      [ -47.2186803817749, -23.078734878405246 ],
      [ -47.219635248184204, -23.079415918799953 ],
      [ -47.22022533416748, -23.079583710831358 ],
      [ -47.22100853919983, -23.07965280160695 ],
      [ -47.221641540527344, -23.079682411928474 ],
      [ -47.222145795822144, -23.07983046343832 ],
      [ -47.22269296646118, -23.080185786396846 ],
      [ -47.22298264503479, -23.08059045862261 ],
      [ -47.22303628921509, -23.080323967293808 ],
      [ -47.2232186794281, -23.080146306114504 ],
      [ -47.22346544265747, -23.080057475436806 ],
      [ -47.22371220588684, -23.079988384869157 ]
]

import boto3
dynamodb = boto3.client('dynamodb')
time = 0
for p in points:
    dynamodb.put_item(
        TableName='track',
        Item={
            'device_id' : { 'S': device_id },
            'event_datetime': { 'N': str(time) },
            'longitude': { 'N': str(p[0]) },
            'latitude': { 'N': str(p[1]) } 
        }
    )
    time += 2

# vim: ts=4:sts=4:sw=4:expandtab
