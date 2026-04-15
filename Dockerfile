# THIS IS A MULTI-STEP BUILD PROCESS
    # Install & Build the required npm stuff
    # Run nginx based on the build
FROM node:25-alpine3.22 as builder

WORKDIR '/usr/app'
COPY package.json ./
RUN npm install
COPY ./ ./

# /usr/app/build will contain all the juice after build
RUN npm run build

FROM nginx
COPY --from=builder /usr/app/build /usr/share/nginx/html
# It is not necessary to specify a command to start up nginx. If we create the container, it will start by itself.