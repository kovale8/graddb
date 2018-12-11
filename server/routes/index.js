const fs = require('fs');
const router = require('express').Router();
const parseUserCookie = require('./util/parseUserCookie');

router.use(parseUserCookie);

router.get('/', (req, res) => {
    res.render('homepage', {title: 'Online Shopping'});
});

fs.readdirSync(__dirname)
    .filter(file => file.endsWith('.js') && file !== 'index.js')
    .map(file => file.slice(0, -3))
    .forEach(file => router.use(`/${file}`, require(`./${file}`)));

module.exports = router;
