# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy app source
COPY . .

# Expose the app's port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
