#!/bin/bash

# ##############################################################################
# Requirements
# ##############################################################################
# 1. Install rsync via homebrew
# 2. Create a password file in ~/.rsync/nas.internal.pingolabs.com.password
# 3. previousle ssh-ed into host machine
# ##############################################################################

DATE="$(date +\%Y-\%m-\%d_\%H-\%M)"

mkdir -p $HOME/Library/Logs/rsync
RSYNC_LOG_PATH="$HOME/Library/Logs/rsync"

# Backup photos library
/opt/homebrew/bin/rsync -avP --delete \
	--password-file=$HOME/.rsync/nas.internal.pingolabs.com.password \
	--log-file="$RSYNC_LOG_PATH/pictures-$DATE.log" \
	$HOME/Pictures \
	rsync@nas.internal.pingolabs.cl::Ignacio\ Olave/

# backup MFH Records project files
#
# Includes:
#   - cubase project files
#   - graphic design work
#   - music related work
/opt/homebrew/bin/rsync -avP \
	--password-file=$HOME/.rsync/nas.internal.pingolabs.com.password \
	--log-file="$RSYNC_LOG_PATH/mfh-records-$DATE.log" \
	$HOME/../../MFH\ Records \
	rsync@nas.internal.pingolabs.cl::Ignacio\ Olave/Backup/

