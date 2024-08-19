# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install Cockpit
RUN apt-get update && \
    apt-get install -y cockpit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the Cockpit web interface port
EXPOSE 9090

# Add a simple startup script
RUN echo '#!/bin/bash\n/usr/libexec/cockpit-ws --no-tls\n' > /start.sh && \
    chmod +x /start.sh

# Use ENTRYPOINT to ensure the service starts with the container
ENTRYPOINT ["/start.sh"]
