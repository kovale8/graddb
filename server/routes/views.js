const format = require('../util/format');
const router = require('express').Router();
const customers = require('../services/customers');

router.get('/', (req, res) => {
    customers.get(1)
    .then(user => res.render('home', {user}));
});

module.exports = router;
