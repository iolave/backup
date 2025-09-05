#!/bin/bash

function info() {
	echo "[INFO] $@"
}

function error() {
	echo "[ERROR] $@"
}

# THIS REPO PATH
ROOT="$( cd "$(dirname "$0")" ; pwd -P )/.."

# GET ALL BASE NAMES FOR ROOT/crontab using find 
CRONTABS=$(find $ROOT/crontab -type f -name "*.crontab")

# FOR EACH CRONTAB GET THE BASE AND STORE IT IN A VARIABLE
for CRONTAB in $CRONTABS; do
	BASE=$(basename $CRONTAB .crontab)
	CRONTAB_BASES="$CRONTAB_BASES $BASE"
done
	
# ALLOW THE USER TO SELECT A BASE
info "choose a crontab config"
PS3="selection: "; select BASE in $CRONTAB_BASES; do
	break
done

# if BASE is empty, exit
if [ -z "$BASE" ]; then
	error "no valid crontab config selected"
	exit 1
fi

# INSTALL THE CRONTAB
echo "INFO: Installing crontab config"
sudo crontab -u $(whoami) $ROOT/crontab/${BASE}.crontab

