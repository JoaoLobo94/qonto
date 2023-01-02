### Instructions
1. Unzip the file
2. Run `bundle install`
3. Start rails server and Sidekiq

This application only has one endpoint:
POST `http://localhost:3000/transactions`
You must upload a transactions JSON file in the body with the key `transactions`

Post the file and you will get a 201 or 422 response depending on the user account balance.

### Issues faced
The main issue is the time limitation of 3h. I went about 15 mins over, finishing at around 20:30.
I have always used Postgres before, so using SQLite was new to me.
Thankfully it's extremely simple to use.

### Potential improvements
Create a docker-compose file with a pg database and a load balancer to emulate real calls to the database.
Add more endpoints for full crud functionality.
Block users from uploading a file without sidekick.# qonto
