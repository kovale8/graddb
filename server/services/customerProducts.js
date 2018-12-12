const db = require('./db');
const products = require('./products');

const customerProducts = {
    getShoppingCart(customerKey) {
        return db.query(`
            SELECT
                product_id AS id,
                product_source AS source,
                product_name AS name,
                price
            FROM ShoppingCartView
            WHERE customer_source = ? AND customer_id = ?
        `, customerKey.split('-'));
    },

    add(customerKey, productKey) {
        return db.query(`
            CALL Add_ShoppingCartItem(?, ?, ?, ?)
        `, customerKey.split('-').concat(productKey.split('-')));
    },

    checkout(customerSource, customerId) {

    }
};

module.exports = customerProducts;