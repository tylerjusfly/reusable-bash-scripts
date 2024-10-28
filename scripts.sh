#!/bin/bash

## Check Internet Status
check_status() {
    echo -ne "\n Internet Status : "
    timeout 3s curl -fIs "https://api.github.com" > /dev/null
    [ $? -eq 0 ] && echo -e "Online" || echo -e "Offline"
}

## Kill already running process
kill_pid() {
	check_PID="php cloudflared loclx"
	for process in ${check_PID}; do #loops through all process in check_PID
		if [[ $(pidof ${process}) ]]; then # Check for Process, this returns the process ID (PID) of the specified process if it is running
			killall ${process} > /dev/null 2>&1 # Kill the Process
		fi
	done
}
