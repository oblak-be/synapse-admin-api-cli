#!/bin/bash

# Constants

HEADER_AUTH="Authorization: Bearer $SYNAPSE_ACCESS_TOKEN"
HEADER_CONTENT_TYPE="Content-Type: application/json"
API_URI="https://$SYNAPSE_HOMESERVER/_synapse/admin"

cget() {

	version="$1"
	path="$2"
	params="$3"

	curl -s -H "$HEADER_AUTH" -H "$HEADER_CONTENT_TYPE" "$API_URI/$version/$path?$params"
}

cput() {

	version="$1"
	path="$2"
	data="$3"
	params="$4"

	curl -s -X PUT -d "$data" -H "$HEADER_AUTH" -H "$HEADER_CONTENT_TYPE" "$API_URI/$version/$path?$params"
}

cpost() {

	version="$1"
	path="$2"
	data="$3"
	params="$4"

	curl -s -X POST -d "$data" -H "$HEADER_AUTH" -H "$HEADER_CONTENT_TYPE" "$API_URI/$version/$path?$params"
}

cdel() {

	version="$1"
	path="$2"
	data="$3"
	params="$4"

	curl -s -X DELETE -d "$data" -H "$HEADER_AUTH" -H "$HEADER_CONTENT_TYPE" "$API_URI/$version/$path?$params"
}
