# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to non-interactive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg2 software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Cockpit's official repository and install Cockpit
RUN curl -fsSL https://download.opensuse.org/repositories/home:pcfe:devel:cockpit/Ubuntu_22.04/Release.key | apt-key add - && \
    add-apt-repository "deb http://download.opensuse.org/repositories/home:/pcfe:/devel:/cockpit/Ubuntu_22.04/ /" && \
    apt-get update && \
    apt-get install -y cockpit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the Cockpit web interface port
EXPOSE 9090

# Start the Cockpit service
CMD ["/usr/libexec/cockpit-ws", "--no-tls"]
