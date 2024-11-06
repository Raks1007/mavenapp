# Use official Maven image to build the project
FROM maven:3.8.4-openjdk-11-slim as builder

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY . .

# Build the project using the desired profile (default is production)
RUN mvn clean package -Pproduction

# Use a lightweight NGINX container to serve the HTML
FROM nginx:alpine

# Copy the built HTML file into the nginx container
COPY --from=builder /app/target/my-maven-app-1.0-Production.jar /usr/share/nginx/html

# Expose the port nginx will run on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]