#!/bin/bash
set -e

# Create the database and run migrations
bundle exec rake db:create db:migrate

# Start the Rails server
bundle exec rails server -b 0.0.0.0
