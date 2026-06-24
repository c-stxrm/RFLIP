# @file prod.Dockerfile
# @brief Builds a production-ready Nginx image
# @author c-stxrm

# Sets the base image to Nginx
# Uses the lightweight Alpine Linux distribution
FROM nginx:alpine

# Declares official image metadata
# Defines the specific version number for this build
LABEL version="1.0.0"

# Copies the local nginx.conf configuration file
# Overwrites the default Nginx configuration in the container
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sets the internal working directory
# Points to the default directory where Nginx serves static files
WORKDIR /usr/share/nginx/html

# Starts the Nginx web server
# Disables daemon mode to keep the container running in the foreground
CMD ["nginx", "-g", "daemon off;"]