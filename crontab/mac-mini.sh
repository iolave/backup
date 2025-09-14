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

# Backup photos library
/opt/homebrew/bin/rsync -avP --delete \
	--password-file=$HOME/.rsync/nas.internal.pingolabs.com.password \
	--log-file="$HOME/Library/Logs/rsync/pictures-$DATE.log" \
	$HOME/Pictures \
	rsync@nas.internal.pingolabs.cl::Ignacio\ Olave/

# backup cubase project files
/opt/homebrew/bin/rsync -avP \
	--password-file=$HOME/.rsync/nas.internal.pingolabs.com.password \
	--log-file="$HOME/Library/Logs/rsync/cubase-$DATE.log" \
	$HOME/Music/cubase \
	rsync@nas.internal.pingolabs.cl::Ignacio\ Olave/Backup/

