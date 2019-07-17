# csc462: Distributed Systems Project
# Boat Data Store: SQL variant

## Contents:
- boats.sql (for now). To provide a sense of how the final schema will probably end up looking like.

- /cluster - Contains the cluster configs, scripts and documentation

- /web: (Under construction) web-based front end for testing and demonstration. Includes Express middleman server to route AJAX requests from client to either mongoDB (not included) or mySQL

## Upcoming:
- Distributed implementation of SQL database
- Other components as appropriate

## Running the front end page
- Navigate to web/client/
- Create a file, ".env", and set its contents as follows:
  - `PORT=3001`
- Head up one level to web/
- Run `npm start & (cd client && npm start)`
