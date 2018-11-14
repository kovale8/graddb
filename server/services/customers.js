const db = require('../db');

const TABLE = 'customer';

const customers = {
    get(id) {
        return db.queryOne(`
            SELECT *
            FROM ${TABLE}
            WHERE customer_id = ${id}
        `);
    }
};

module.exports = customers;
