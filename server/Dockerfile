FROM ruby:2.3

RUN apt-get update
## Rails 4.2 dependencies
RUN apt-get install -y sqlite3 libsqlite3-dev \
                    postgresql postgresql-client \
                    postgresql-contrib libpq-dev redis-server memcached \
                    imagemagick ffmpeg mupdf mupdf-tools libxml2-dev

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y yarn

COPY Gemfile Gemfile

RUN bundle install

EXPOSE 3000

WORKDIR /sm

COPY . .