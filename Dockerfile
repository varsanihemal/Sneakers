# Dockerfile
FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libpq-dev
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
