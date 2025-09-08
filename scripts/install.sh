#!/bin/bash

function info() {
	echo "[INFO] $@"
}

function error() {
	echo "[ERROR] $@"
	exit 1
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
fi

# INSTALL THE CRONTAB
info "installing crontab config"
sudo crontab -u $(whoami) $ROOT/crontab/${BASE}.crontab

if [ -f $ROOT/crontab/${BASE}.sh ]; then
	info "installing backup script"

	if [ ! -d "/opt/iolave/bin" ]; then
		sudo mkdir -p /opt/iolave/bin
	fi

	sudo chown -R $(whoami) /opt/iolave/bin
	cp $ROOT/crontab/${BASE}.sh /opt/iolave/bin/crontab-backup.sh
fi

