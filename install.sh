#!/bin/bash

function install_dependencies() {

	apt update

	dependencies=(
	"openssl"
	"curl"
	"jq"
	)

	for package in ${dependencies[@]}; do

		which $package >> /dev/null

		if [ "$?" != 0 ]; then
			apt install -y $package
		fi
	done
}

function create_directories() {

	mkdir -p /etc/synapse-admin
	mkdir -p /lib/synapse-admin
}

function copy_libs() {

	cp -ra $PWD/lib/*.sh /lib/synapse-admin/
}

function copy_script() {

	execution_path=$(echo $PATH | cut -d ":" -f 1)

	cp -ra $PWD/synapse-admin $execution_path/synapse-admin

	sed -i 's/$PWD\/lib/\/lib\/synapse-admin/' $execution_path/synapse-admin


	which synapse-admin

	if [ "$?" != 0 ]; then
		echo "[ERROR] Something went wrong during the installation"
	else
		echo "[INFO] synapse admin succesfully installed"
	fi
}

function main() {

	if [ "$(id -u)" != 0 ]; then
		echo "[ERROR] You must run this installation script as root"
		exit 1
	fi

	install_dependencies
	create_directories
	copy_libs
	copy_script

}

main
