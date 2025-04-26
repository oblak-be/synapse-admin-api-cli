#!/bin/bash

retention="6 months"

room_ids=($(synapse-admin get room --all | jq -r '.rooms[].room_id'))

for room_id in ${room_ids[@]}; do

	synapse-admin delete room --room-id  --history $(date +%m/%d/%Y -d "$retention ago")
	sleep 20
done
