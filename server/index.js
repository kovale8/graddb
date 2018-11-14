const db = require('./db');
const express = require('express');
const hbs = require('hbs');
const path = require('path');
const routes = require('./routes');

const app = express();

// Assign url routes.
app.use(routes);
app.use('/static', express.static(path.join(__dirname, 'static')));

// Set up the template engine.
const viewPath = path.join(__dirname, 'views');
app.set('view engine', 'hbs');
app.set('views', viewPath);
hbs.registerPartials(path.join(viewPath, 'partials'));

// Initialize the listening loop.
app.listen(9000, 'localhost', () =>
    console.log('nile server is running'));
