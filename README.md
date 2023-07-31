Lunch Matcher is a monolithic React / Ruby application. It uses Vite for faster development of the Frontend.

# Installation

## Pre-requisites
* Node v16
* Ruby 3.2.2

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

# How to use

It should be mostly self explanatory, but access the server with `localhost:3000`. You should see the Lunch Matcher hero and an empty table, that you can fill using the Modal that opens with clicking the `+` sign in the top left corner. Same goes for other Tabs (Department). The last tab is the Rounds tab, where you can match the Employees through departments. At the moment there is no way of deleting Employees, Departments and Rounds in the UI. The tester is invited to remove it using `bundle exec rails c` and deleting directly in the model e.g.: `Employee.last.destroy`

### Troubleshooting

- You may have errors with nokogiri which you can fix with `bundle update nokogiri`
- If you don't have postgres installed remember to install `postgresql postgresql-contrib libpq-dev` before running `bundle install`. Create the password (default `root`) with:
```
sudo -u postgres psql

\password postgres
postgres
```

---
