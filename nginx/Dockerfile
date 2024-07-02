FROM nginx:mainline

# Configure IST Timezone
ENV TZ="Asia/Kolkata"

# Install inotifytools for reloading config on change
RUN apt-get update -y && apt-get install -y inotify-tools

WORKDIR /app

# Copy config file
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/

# Set up the watcher.
COPY watch_reload.sh ./

ENTRYPOINT [ "./watch_reload.sh" ]