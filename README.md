# Sage test - Rick and Morty API

## Comments
* For pagination I used the gem pagy which seems to perform better than will_paginate.
* Front-end is done with bootstrap.
* Periodic task that has to run every 12 hours uses the gem whenever to create the crontab file. It calls a rake task that uses a service to import all data through the Rick and Morty API.
