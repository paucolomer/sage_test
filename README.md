# Sage test - Rick and Morty API

## Comments
* For pagination I used the gem pagy which seems to perform better than will_paginate.
* Front-end is done with bootstrap.
* Periodic task that has to run every 12 hours uses the gem whenever to create the crontab file. It calls a rake task that uses a service to import all data through the Rick and Morty API.

## Configuration



```bash
# Clone this repository
git clone https://github.com/paucolomer/sage_test.git

# Move to the rails project cloned
cd sage_test

# Run migrations
$ rake db:migrate

# Import all data from the Rick and Morty API
$ rake rick_and_morty:import

# Update the contrab file with the corresponding job to ensure every 12 hours the import task is executed
$ whenever --update-crontab

# Start the app server
$ bin/rails server

# Visit the index page where characters are listed
$ firefox http://localhost:3000
```
## Tests

The following tests are implemented:
* Integration test for the controller
* Character model test
* System test. It uses firefox so you may need to install the geckodriver from https://github.com/mozilla/geckodriver/releases


```
rake test
PATH=$PATH:/path/to/geckodriver rake test:system
```
