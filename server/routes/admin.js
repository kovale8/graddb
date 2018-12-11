const customers = require('../services/customers');
const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('admin', {
        title: 'Admin',
        hideStatus: true,
        options: [
            'customers'
        ]
    });
});

router.get('/customers', (req, res) =>
    customers.getAll().then(customerList =>
        res.render('customerList', {
            title: 'Customers',
            hideStatus: true,
            customers: customerList
        })));

module.exports = router;