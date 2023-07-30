FROM node:18
FROM ruby:3.2.2

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler
# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update &amp;&amp; \
    apk upgrade &amp;&amp; \
    apk add $BUILD_PACKAGES &amp;&amp; \
    apk add $RUBY_PACKAGES &amp;&amp; \
    rm -rf /var/cache/apk/*
RUN mkdir /usr/app
WORKDIR /usr/app
COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install
COPY . /usr/app

# EXPOSE 8080
# CMD [ "node", "server.js" ]