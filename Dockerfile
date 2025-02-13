# Use Node.js 18 with Debian 12 slim
FROM node:18-bookworm-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Create a non-root user and switch to it
RUN useradd --create-home --shell /bin/bash appuser

# Copy package.json and package-lock.json
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Change ownership of the app directory
RUN chown -R appuser:appuser /usr/src/app

# Switch to the non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 3000

# Define the command to start the app
CMD ["npm", "start"]
