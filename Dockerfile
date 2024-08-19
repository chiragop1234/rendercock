# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to non-interactive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    docker.io

# Set the working directory for JupyterLab
WORKDIR /app

# Install JupyterLab
RUN pip3 install jupyterlab

# Create a startup script to run the Wings container and JupyterLab
RUN echo '#!/bin/bash\n\
docker run -d --restart=always --hostname=CompixCloudPtero --cap-add=NET_ADMIN -v /var/lib/pterodactyl:/var/lib/pterodactyl -v /home/user/melan/docker:/var/lib/docker -v /tmp/pterodactyl:/tmp/pterodactyl -v /tmp/docker.sock:/var/run/docker.sock melantrance/wings:latest\n\
jupyter lab --ip=0.0.0.0 --port=8080 --no-browser --allow-root --NotebookApp.token=""' > /start_services.sh

# Make the script executable
RUN chmod +x /start_services.sh

# Expose the JupyterLab port
EXPOSE 8080

# Start the services
ENTRYPOINT ["/bin/bash", "/start_services.sh"]
