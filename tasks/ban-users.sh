#!/bin/bash

if [ -z "$1" ]; then
	echo "Provide a list of users to ban."
	echo ""
	echo "Users will be deactivated and media uploaded by the user removed."
	echo ""
	echo "Usage:"
	echo ""
	echo "ban-users.sh [non-compliant-users.txt]"
	exit 0
fi

user_list=($(cat $1))

for user in ${user_list[@]}; do

	synapse-admin update users --user-id $user --deactivate
	synapse-admin delete media --user-id $user

	echo "[INFO] User $user deactivated."
done
