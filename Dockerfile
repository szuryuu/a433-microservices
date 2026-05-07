# use Node.js 14 on Alpine Linux as the lightweight base image.
FROM node:14-alpine

# add label source repository for this image.
LABEL org.opencontainers.image.source="https://github.com/szuryuu/a433-microservices"

# set /app as the working directory
WORKDIR /app

# copy all project files to /app
COPY . /app

# set production mode and configure the database host environment variable
ENV NODE_ENV=production DB_HOST=item-db

# install only production dependencies, allow unsafe permissions, then build the app.
RUN npm install --production --unsafe-perm && npm run build

# container listens on port 8080.
EXPOSE 8080

# start the application using npm
CMD ["npm", "start"]
