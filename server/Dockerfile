
FROM ruby:2.7.2-alpine

WORKDIR /sm

RUN apk add --update \
  build-base \
  postgresql-dev \
  sqlite-dev \
  nodejs \
  tzdata \
  git \
  && rm -rf /var/cache/apk/*

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .
