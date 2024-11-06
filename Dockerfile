# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-11 AS build

WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/maven-project-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]