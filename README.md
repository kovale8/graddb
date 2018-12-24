# Nile Online Shopping Experience

## Dependencies

* [NodeJS](https://nodejs.org/en)
* [Sass](https://sass-lang.com/install)

## Build the necessary files

`$ npm install`

`$ npm run build-css`

## Run the program

Start the server with: `$ ./bin/www`

For a database connection, the following environment variables must be made
available to the process:

* `DB_HOST`: database instance host
* `DB_USER`: user to use for the connection
* `DB_PASSWORD`: user's password
* `DB_NAME`: database name

Optional environment variables include:

* `PORT`: port on which the node server will listen. **Default: 3000**

## Additional notes

The node server does not serve static files. A reverse proxy like
[NGINX](https://nginx.com) is required.
