const db = require('./db');
const express = require('express');

const app = express();

db.query(
    'SELECT first_name, last_name ' +
    'FROM customers ' +
    'WHERE id = 1')
.then(console.log);

app.listen(9000, 'localhost', () =>
    console.log('nile server is running'));
