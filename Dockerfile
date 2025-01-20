# Use Node.js 16 slim as the base image for building the app
FROM node:16-slim as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Use a lightweight web server (e.g., Nginx) to serve the static files
FROM nginx:stable-alpine

# Copy the built React app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 (default Nginx port)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
