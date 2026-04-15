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
# Elasticbeanstalk is going to need an exposed port, e.g. 80 (the default for nginx), for its mapping. That is why we need to explicitly set it here below. If we leave out an EXPOSE, the deployment will fail
EXPOSE 80 
COPY --from=builder /usr/app/build /usr/share/nginx/html
# It is not necessary to specify a command to start up nginx. If we create the container, it will start by itself.