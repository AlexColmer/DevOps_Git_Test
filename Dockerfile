# Get Nginx image from Dockerhub
FROM nginx
# Who is creating this? Optional
LABEL MAINTAINER=luke@spartaglobal.com

# Created index.html cv - copy to container (default location -> usr/share/nginx/html/)
COPY index.html /usr/share/nginx/html/
COPY cv_css.css /usr/share/nginx/html/
COPY /images /usr/share/nginx/html/
# Commit the change

# Push the new image

# Pull the image from repo

# Run -> run -d -p 80:80 name

# Port number
EXPOSE 80

# Launch the server
CMD ["nginx", "-g", "daemon off;"]

# Note - each command is a layer in the eventual zip
