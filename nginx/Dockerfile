FROM nginx:mainline

# Install inotifytools for reloading config on change
RUN apt-get update -y && apt-get install -y inotify-tools

# Copy config file
COPY nginx.conf /etc/nginx/
RUN rm /etc/nginx/conf.d/default.conf

# Set up the watcher.
COPY watch_reload.sh /

ENTRYPOINT [ "/watch_reload.sh" ]