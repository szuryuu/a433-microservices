# Use Node 20 Alpine
FROM node:20-alpine AS builder

# Define app working folder
WORKDIR /app

# Copy dependency manifest files
COPY package*.json ./

# Install all npm dependencies
RUN npm install

# Copy full project source
COPY . .

# Expose application port 3001
EXPOSE 3001

# Start app via npm
CMD [ "npm", "start" ]
