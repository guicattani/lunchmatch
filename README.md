Rails 7 Vite React Template is a monolithic React / Ruby application. It uses Vite for faster development of the Frontend.

## Technologies used

Backend

```
ruby 3.2.2
rails 7.0.6
postgresql
```

Frontend

```
Node v16
Vite
```

## First steps

- First and foremost run `bundle install` and `npm install` to make everything tidy and green. Be mindful of the Node and Ruby versions, syntax might break if those are changed
- Change all `lunch_matcher` and `lunch_matcher` occurences to your desired app name
-  Environment variables are stored in `.env`. A sample file was provided, run `mv .env.sample .env` to rename it so `rails-dotenv` can read them in runtime.


## Setup dependencies

```
npm install
bundle install
rails db:prepare
```

## Start the server

Start Vite dev server with:

```
./bin/vite dev
```

And Rails with:

```
bundle exec rails s
```

## Run tests

### BE

```
bundle rails db:prepare RAILS_ENV=test
bundle exec rspec
```

### FE

```
npm run test
```
