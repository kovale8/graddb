const customers = require('../services/customers');
const products = require('../services/products');
const router = require('express').Router();
const suppliers = require('../services/suppliers');

router.get('/', (req, res) => {
    res.render('admin', {
        title: 'Admin',
        hideStatus: true,
        options: [
            'customers',
            'products',
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

router.get('/products', (req, res) =>
    products.getAll().then(productList =>
        res.render('report', {
            title: 'Products',
            hideStatus: true,
            report: {
                rows: productList,
                columns: [
                    ['Product ID', 'id'],
                    ['Name', 'name'],
                    ['Category', 'category'],
                    ['Source', 'source']
                ]
            }
        })));

router.get('/suppliers', (req, res) =>
    suppliers.getAll().then(supplierList =>
        res.render('supplierList', {
            title: 'Suppliers',
            hideStatus: true,
            suppliers: supplierList
        })) )

module.exports = router;