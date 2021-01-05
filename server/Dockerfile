
FROM ruby:2.7.2-alpine

RUN apk add --update \
  build-base \
  postgresql-dev \
  sqlite-dev \
  nodejs \
  tzdata \
  git \
  && rm -rf /var/cache/apk/*

COPY Gemfile Gemfile

RUN bundle install

EXPOSE 3000

WORKDIR /sm

COPY . .