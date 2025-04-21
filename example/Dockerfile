# Choose the appropriate image
FROM alpine:latest AS app

# Run any build or setup or anything else here
RUN apk --no-cache add tzdata ca-certificates bash
ENV TZ="Asia/Kolkata"
WORKDIR /app

# Copy the metaploy configuration to the container
COPY metaploy/ ./

# Make the postinstall script executable
RUN chmod +x ./postinstall.sh

# Copy any source files
COPY ./build .

# Run the postinstall script when the container starts
CMD ["./postinstall.sh", "./build/server"]