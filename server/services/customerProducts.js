const db = require('./db');

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
            CALL Add_ShoppingCartItem(?, ?, ?, ?, ?)
        `, customerKey.split('-').concat(productKey.split('-')).concat(1));
    },

    checkout(customerSource, customerId) {
        return db.query(`
            SET @order = 0;
            CALL CheckoutCustomer(?, ?, @order);
            SELECT 
                shipping_date
            FROM PurchaseOrder
            WHERE order_id = @order;
        `, [customerSource, customerId]).then(result =>
                result[2][0].shipping_date);
    }
}

module.exports = customerProducts;