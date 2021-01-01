FROM ruby:2.2

RUN apt-get -y update && apt-get install -y sqlite3 libsqlite3-dev

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

EXPOSE 3000

WORKDIR /sm

COPY . .