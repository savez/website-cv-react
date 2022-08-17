FROM node:12-slim

ARG NPM_REGISTRY="https://registry.npmjs.org"

WORKDIR /usr/src/app

# Install python for serverless snappy
RUN apt-get update && apt-get install -y python3 python3-dev python3-pip

RUN npm install --global gulp-cli

# Install dependencies
RUN yarn config set registry ${NPM_REGISTRY} \
    && yarn config set strict-ssl false

COPY package.json /usr/src/app/

RUN cd /usr/src/app && yarn install --frozen-lockfile


# Configure the entrypoint script.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy the app.
COPY . /usr/src/app

ENTRYPOINT ["/entrypoint.sh"]
