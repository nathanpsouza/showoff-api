FROM ruby:2.6.5

RUN apt-get update -qq \
    && apt-get install -y \
        build-essential libpq-dev nodejs \
        postgresql postgresql-client

RUN mkdir /app
WORKDIR /app

COPY . /app

RUN gem install bundler \
    && bundle install

EXPOSE 3001

CMD bundle exec rails s -p 3001 -b '0.0.0.0'
