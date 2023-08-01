#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails db:create
bundle exec rails db:prepare
bundle exec rails db:seed

npm run dev &
P1=$!
bundle exec rails server -b 0.0.0.0 &
P2=$!
wait $P1 $P2

