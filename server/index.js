const cookieParser = require('cookie-parser');
const express = require('express');
const hbs = require('hbs');
const helpers = require('./views/helpers');
const path = require('path');
const routes = require('./routes');

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(routes);

// Set up the template engine.
const viewPath = path.join(__dirname, 'views');
app.set('view engine', 'hbs');
app.set('views', viewPath);
hbs.localsAsTemplateData(app);
hbs.registerPartials(path.join(viewPath, 'partials'));
helpers.bind(hbs);

module.exports = app;
