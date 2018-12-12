const fs = require('fs');
const router = require('express').Router();
const parseUserCookie = require('./util/parseUserCookie');
const products = require('../services/products');

router.use(parseUserCookie);

router.get('/', (req, res) =>
    products.getCategories().then(categories => res.render('homepage', {
        title: 'Online Shopping',
        categories
    })));

fs.readdirSync(__dirname)
    .filter(file => file.endsWith('.js') && file !== 'index.js')
    .map(file => file.slice(0, -3))
    .forEach(file => router.use(`/${file}`, require(`./${file}`)));

module.exports = router;
