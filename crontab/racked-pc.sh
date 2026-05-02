#!/bin/bash

# ##############################################################################
# Requirements
# ##############################################################################
# 1. Install rsync via apt
# 2. Create a password file in ~/.rsync/nas.local.password
#    with permissions chmod 600
# 3. previously ssh-ed into host machine
#    ssh-copy-id localhost
# 4. the log directory has to be created
#    mkdir -p /var/log/rsync
#    and the user/group need write permissions
#    chmod 2775 /var/log/rsync
# 5. the log directory has to be accessible by the user/group
#    chown -R root:users /var/log/rsync
# 6. make sure the directory is created in the remote
#    Ignacio\ Olave/Backup/racked-pc
# ##############################################################################

DATE="$(date +\%Y-\%m-\%d_\%H-\%M)"

RSYNC_LOG_PATH="/var/log/rsync"
RSYNC_BIN="/usr/bin/rsync"
HOST="192.168.1.35"

function sync() {
	SRC="$1"
	DEST="$2"

	$RSYNC_BIN -avP \
		--password-file="$HOME/.rsync/nas.local.password" \
		--log-file="$RSYNC_LOG_PATH/iolave-${DEST}-${DATE}.log" \
		${SRC} \
		rsync@${HOST}::Ignacio\ Olave/Backup/racked-pc/${DEST}/
}

# sync "/mnt/bulk/photos/" "photos"

