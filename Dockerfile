# Use a Go base image
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application files
COPY . .

# Build the application
RUN go build -o hello-world .

# Use an Alpine base image for the final container
FROM alpine:latest

# Copy the binary from the build container
COPY --from=builder /app/hello-world .

# Expose the port
EXPOSE 8080

# Command to run the application
CMD ["./hello-world"]
