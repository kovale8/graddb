# Nile Online Shopping Experience

## Initialize the Database

Store your mysql login data in the file `.my.cnf` in your home directory.
(This might be different for Windows.) Format the file as:
```
[client]
host = <your host>
user = <your username>
password = <your password>
```

When running the node application (described below), you may receive an error
relating to authentication failure. In that case run the following command in
mysql:
```
alter user 'USER'@'localhost' identified with mysql_native_password by 'PASSWORD'
```

## Run the Program

Download [NodeJS](https://nodejs.org/en/).

Install all dependencies with `npm install`.

Run the server with `node server`.
