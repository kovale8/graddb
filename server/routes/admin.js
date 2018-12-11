const customers = require('../services/customers');
const router = require('express').Router();
const suppliers = require('../services/suppliers');

router.get('/', (req, res) => {
    res.render('admin', {
        title: 'Admin',
        hideStatus: true,
        options: [
            'customers',
            'suppliers'
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

router.get('/suppliers', (req, res) =>
    suppliers.getAll().then(supplierList =>
        res.render('supplierList', {
            title: 'Suppliers',
            hideStatus: true,
            suppliers: supplierList
        })) )

module.exports = router;