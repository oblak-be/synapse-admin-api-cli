#!/bin/bash

if [ -z "$1" ] || [ "$1" == "--help" ]; then

	echo "Scan your matrix homeserver for TOS violations"
	echo ""
	echo "This script first scans room names and topics for suspicious words, and compiles a list of room ids"
	echo "It will then scan the suspicious rooms for members that have an account on your homeserver"
	echo ""
	echo "Usage:"
	echo "scan-violations.sh [path/to/wordlist.txt] [homeserver domain]"
	exit 0
fi

if [ -z "$2" ]; then
	echo "[ERROR] No homeserver domain supplied"
	echo ""
	echo "[INFO] reminder: scan-violations.sh [path/to/wordlist.txt] [homeserver domain]"
	exit 1
fi

WORD_LIST=($(cat $1))
HOMESERVER="$2"

rooms_that_violate_tos=()
users_that_violate_tos=()

#
# Create a cached list of all rooms on the server.
#
if [ ! -f all-rooms.json ]; then

	synapse-admin get rooms --all --output all-rooms.json
fi

#
# Scan the rooms for suspicious use of words
#
rooms=($(cat all-rooms.json | jq -r 'select(.name != null) | select(.joined_local_members > 0) | .room_id'))

for room in ${!rooms[@]}; do

	room_id="${rooms[$room]}"

	room_name=$(cat all-rooms.json | jq -r 'select(.room_id == "'$room_id'") | .name')
	room_topic=$(synapse-admin get room --room-id ''$room_id'' | jq '.topic')

	for word in ${WORD_LIST[@]}; do

		word_check=$(echo "$room_name" | grep -i "$word" | wc -l)

		if [ "$word_check" == 1 ]; then

			rooms_that_violate_tos+=($room_id)
			echo "[INFO] Added $room_name to violation list because word $word was found in $room_name"
		fi

		word_check=$(echo "$room_topic" | grep -i "$word" | wc -l)

		if [ "$word_check" == 1 ]; then

			rooms_that_violate_tos+=($room_id)
			echo "[INFO] Added $room_name to violation list because word $word was found in $room_topic"
		fi
	done
done

#
# Process rooms, filter doubles
#
for room in ${rooms_that_violate_tos[@]}; do

	echo $room >> rooms-that-violate-tos.txt
done

cat rooms-that-violate-tos.txt | sort | uniq > non-compliant-rooms.txt && rm rooms-that-violate-tos.txt

non_compliant_rooms=($(cat non-compliant-rooms.txt))

#
# Scan suspicious rooms for members
#
for room in ${non_compliant_rooms[@]}; do

	users_that_violate_tos+=($(synapse-admin get room --room-id ''$room'' --show-members | jq -r '.members[]' | grep "$HOMESERVER"))
done

for user in ${users_that_violate_tos[@]}; do

	echo $user >> users-that-violate-tos.txt
	echo "[INFO] User $user added to violation list"
done

cat users-that-violate-tos.txt | sort | uniq > non-compliant-users.txt && rm users-that-violate-tos.txt
