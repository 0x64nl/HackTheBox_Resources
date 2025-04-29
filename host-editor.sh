#!/bin/bash
set -ex
function show_help () {
	echo "Usage $0 <IP> <hostname1> <hostname2>...."
}

function process_args () {	
	if [ "$#" -lt 2 ];then
		show_help
		exit 1
	fi

	IP="$1"
	if [[ ! $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  	  	echo "Invalid IPv4 format"
    		exit 1
	fi
	shift
	HOSTNAMES="$@"
	LINE="$IP $HOSTNAMES"
}
function edit_hosts_file {
	sed -i '/#HTB_TARGETS/ q' /etc/hosts
	echo "$LINE" | sudo tee -a /etc/hosts > /dev/null
}
process_args $@
edit_hosts_file

