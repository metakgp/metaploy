#!/bin/sh

# Run this script with the binary or the command that starts the project
# Eg: ./postinstall.sh npm start
# Eg: ./postinstall.sh ./build/server

# This function reomves the metaploy config file from the volume when the project crashes or stops
cleanup() {
	echo "Container stopped. Removing nginx configuration."
	rm /etc/nginx/sites-enabled/project.metaploy.conf
}

# Run the cleanup function if either of the below signals are received
trap 'cleanup' SIGQUIT SIGTERM SIGHUP

# Run the command provided to the arguments (starts the project server)
"${@}" &

# Copies the metaploy config file to the correct directory
cp ./project.metaploy.conf /etc/nginx/sites-enabled

# Waits for the server process to stop (lets it run)
wait $!
