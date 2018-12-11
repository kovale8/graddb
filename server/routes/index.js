const customers = require('../services/customers');
const router = require('express').Router();
const views = require('./views');

router.use((req, res, next) => {
    const userCookie = req.cookies.user;
    if (!userCookie)
        return next();

    const id = userCookie.split('-');
    customers.get(id[0], id[1])
    .then(customer => {
        if (customer)
            res.locals.user = customer;
        next();
    });
});

router.use('/', views);

module.exports = router;
