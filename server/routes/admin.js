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
            'inventory',
            'suppliers',
            'restock',
            'nonactive',
            'notsellingtoowell'
        ].sort()
    });
});

router.get('/customers', (req, res) =>
    customers.getAll().then(customerList =>
        res.render('customerList', {
            title: 'Customers',
            hideStatus: true,
            customers: customerList
        })));

router.get('/inventory', (req, res) =>
    products.getInventory().then(inventory =>
        res.render('report', {
            title: 'Inventory',
            hideStatus: true,
            report: {
                rows: inventory,
                columns: [
                    ['Product ID', 'id'],
                    ['Name', 'name'],
                    ['# In Stock', 'inventory']
                ]
            }
        })));

router.get('/nonactive', (req, res) =>
    customers.getNonActive().then(cust =>
        res.render('report', {
            title: 'Customers Who Have Not Been Too Active',
            hideStatus: true,
            report: {
                rows: cust,
                columns: [
                    ['Customer ID', 'id']
                ]
            }
        })));

router.get('/notsellingtoowell', (req, res) =>
    products.getNotSellingTooWell().then(prod =>
        res.render('report', {
            title: 'Products That Are Not Selling Too Well',
            hideStatus: true,
            report: {
                rows: prod,
                columns: [
                    ['Product ID', 'id'],
                    ['Name', 'name'],
                    ['Target Units Sold', 'targetUnitsSold'],
                    ['Monthly Count', 'monthlyCount']
                ]
            }
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

router.get('/restock', (req, res) =>
    products.getNeedsRestock().then(restock =>
        res.render('report', {
            title: 'Needs Restocking',
            hideStatus: true,
            report: {
                rows: restock,
                columns: [
                    ['Product ID', 'id'],
                    ['Name', 'name'],
                    ['Price', 'price'],
                    ['# In Stock', 'inventory'],
                    ['Minimum Stock Level', 'minimumStockLevel']
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