const customers = require('../services/customers');
const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('homepage');
});

router.get('/customers', (req, res) => {
    customers.getAll()
    .then(customerList => res.render('customers', {
        title: 'Customers',
        customers: customerList
    }));
});

module.exports = router;
