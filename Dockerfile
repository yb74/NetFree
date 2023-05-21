# Download base image ubuntu 23.04
FROM ubuntu:latest
# information about the image
LABEL authors="younes"
LABEL description="This is a custom Docker Image for nodejs and Nginx."

#first command to be executed when container runs
ENTRYPOINT ["top", "-b"]

# Node config
# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:latest as build
# Set the working directory
WORKDIR /usr/local/app
# Add the source code to app
COPY ./ /usr/local/app/
# Install all the dependencies
RUN npm install
# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server
# Use official nginx image as the base image
FROM nginx:latest
# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/net-free /usr/share/nginx/html
# Expose port 80
EXPOSE 80
