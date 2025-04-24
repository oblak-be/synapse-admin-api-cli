#!/bin/bash

function preflight_checks() {

	dependencies=(
	"openssl"
	"curl"
	"jq"
	)

	for package in ${dependencies[@]}; do

		which $package >> /dev/null

		if [ "$?" != 0 ]; then
			echo "Synapse Admin v3 - CLI wrapper to interact with the Matrix Synapse Admin API"
			echo ""
			echo "[ERROR] Required dependency $package seems not installed"
			exit 1
		fi
	done
}

preflight_checks
