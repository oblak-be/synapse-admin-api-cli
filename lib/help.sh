#!/bin/bash

function general_help() {

        echo "Synapse Admin v3 - CLI wrapper to interact with the Matrix Synapse Admin API"
        echo ""
        echo "Commands:"
        echo "---------"
        echo ""
        echo "get    - retrieve inforamtion about resources on this server"
        echo "create - create new resources on this server"
        echo "update - update existing resources on this server"
        echo "delete - delete existing resources from this server"
        echo ""
        echo "Resources:"
        echo "----------"
        echo ""
        echo "users       - users on this server"
        echo "rooms       - chatrooms on this server"
	echo "media       - media on this server (video, photos, ..)"
        echo "jobs        - server maintenance background jobs "
	echo ""
        echo "Usage:"
        echo "------"
        echo ""
        echo "synapse-admin [verb] [resource] [options]"
        echo ""
        echo ""
        echo "To learn more about the Synapse Admin API, visit https://element-hq.github.io/synapse/latest/usage/administration/admin_api"
        echo ""
}

function verb_help_get() {

	echo "Resources:"
	echo "----------"
	echo ""
	echo "users       - get detailed information about users on this server"
	echo "rooms       - get detailed information about rooms on this server"
	echo "media       - get detailed information about media on this server"
	echo "jobs        - get detailed information about media on this server"
	echo "federation  - get information about homeservers that are federated with this server"
	echo "version     - get the synapse version this server is running"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin get [resource] [options]"
}

function verb_help_create() {

	echo "Resources:"
	echo "----------"
	echo ""
	echo "jobs       - create background jobs for this server"
	echo "notices    - send a server notice"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin create [resource] [options]"
}

function verb_help_update() {

	echo "Resources:"
	echo "----------"
	echo ""
	echo "users       - update users on this server"
	echo "rooms       - update rooms on this server"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin update [resource] [options]"
}

function verb_help_delete() {

	echo "Resources:"
	echo "----------"
	echo ""
	echo "media       - delete media on this server"
	echo "rooms       - delete rooms on this server"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin delete [resource] [options]"
}

function resource_help_get_users() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--all               - list all existing users, including deactivated & locked users"
	echo "--output  [file]    - save a list of users to a file"
	echo "--user-id [user_id] - show details about a specific user"
	echo "--show-memberships  - show the rooms a user is a member to"
	echo "--statistics        - get 100 biggest users in terms of diskspace consumption"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin get users [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin get users --all --output users.json"
	echo "synapse-admin get user --user-id @john:oblak.be"
	echo "synapse-admin get user --user-id @john:oblak.be --show-memberships"
}

function resource_help_get_rooms() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--all               - list all existing rooms"
	echo "--output  [file]    - save list of rooms to a file"
	echo "--room-id [room_id] - show details about a specific room"
	echo "--show-members      - show a list members of the room"
	echo "--statistics        - get 10 largest rooms and estimated diskspace they are taking"
	echo "--is-blocked        - show the blocked status of a room"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin get rooms [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin get rooms --all --output rooms.json"
	echo "synapse-admin get rooms --statistics"
	echo "synapse-admin get room  --room-id '!xfdfjsigedfsf:oblak.be'"
	echo "synapse-admin get room  --room-id '!xfdfjsigedfsf:oblak.be' --show-members"
}

function resource_help_get_rooms() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--all               - list all existing rooms"
	echo "--output  [file]    - save list of rooms to a file"
	echo "--room-id [room_id] - show details about a specific room"
	echo "--show-members      - show a list members of the room"
	echo "--statistics        - get 10 largest rooms and estimated diskspace they are taking"
	echo "--is-blocked        - show the blocked status of a room"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin get rooms [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin get rooms --all --output rooms.json"
	echo "synapse-admin get rooms --statistics"
	echo "synapse-admin get room  --room-id '!xfdfjsigedfsf:oblak.be'"
	echo "synapse-admin get room  --room-id '!xfdfjsigedfsf:oblak.be' --show-members"
}

function resource_help_create_jobs() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--regenerate-directory    - recalculate the user directory if it is stale or out of sync"
	echo "--populate-stats          - recalculate the stats for all rooms"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin create jobs [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin create jobs --regenerate-directory"
}

function resource_help_create_notices() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--message [message text] - send a serverwide text notice"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin create notice [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin create notice --message 'This is a test notice'"
}

function resource_help_update_users() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--user-id [user-id] - update a specific user"
	echo "--deactivate        - deactive a user account"
	echo "--lock              - lock a user account"
	echo "--suspend           - suspend a user account"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin update users [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin update users --user-id @john:oblak.be --suspend"
}

function resource_help_update_rooms() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--room-id [room-id] - update a specific room"
	echo "--block             - block a room"
	echo "--unblock           - unblock a room"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin update users [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin update rooms --room-id '!xfdfjsigedfsf:oblak.be' --block"
}

function resource_help_delete_media() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--user-id [user-id]    - delete all media for a specific user"
	echo "--local  [MM/DD/YYYY]  - delete local media since date"
	echo "--remote [MM/DD/YYYY]  - delete remote media since date"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin delete media [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin delete media --user-id @john:oblak.be"
	echo "synapse-admin delete media --local 01/01/2023"
}

function resource_help_delete_rooms() {

	echo "Options:"
	echo "------"
	echo ""
	echo "--room-id [room-id]    - execute delete actions on a specific room"
	echo "--history [MM/DD/YYYY] - purge the history of the room since date (this does not delete the room itself)"
	echo "--force                - delete and purge the room (this is irreversible)"
	echo "--status               - show the status of a room that's being deleted"
	echo ""
	echo "Usage:"
	echo "------"
	echo ""
	echo "synapse-admin delete room [options]"
	echo ""
	echo "Example:"
	echo "--------"
	echo ""
	echo "synapse-admin delete room --room-id '!xfdfjsigedfsf:oblak.be' --force"
	echo "synapse-admin delete room --room-id '!xfdfjsigedfsf:oblak.be' --history 01/02/2023"
}
