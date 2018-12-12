const db = require('./db');

const customerProducts = {
    getShoppingCart(customerSource, customerId) {

    },

    add(customerKey, productKey) {
        return db.query(`
            CALL Add_ShoppingCartItem(?, ?, ?, ?)
        `, customerKey.split('-').concat(productKey.split('-')));
    }
};

module.exports = customerProducts;