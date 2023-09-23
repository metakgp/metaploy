#!/bin/bash
# A script that reloads the nginx configuration if it changed.

# Thanks to https://cyral.com/blog/how-to-auto-reload-nginx/

watch_reloads () {
	if [[ $(command -v inotifywait) != "" ]];
	then
		while true
		do
			inotifywait --exclude .swp -e create -e modify -e delete -e move /etc/nginx/sites-enabled/

			echo "Detected Nginx configuration change."

			# Tests the new configuration
			nginx -t

			if [ $? -eq 0 ]
			then
				echo "Configuration OK. Executing: nginx -s reload"
				nginx -s reload
			else
				echo "Error in configuration. Did not reload Nginx."
			fi
		done
	else
		echo "Inotifywait not found. Configuration reloads cannot be done."
		exit 1
	fi
}

watch_reloads &

nginx -g 'daemon off;'