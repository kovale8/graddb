const db = require('./db');

const customers = {
    get(source, id) {
        return db.query(`
            SELECT
                first_name,
                last_name,
                email_address,
                is_admin
            FROM Customer_View
            WHERE source = ? AND customer_id = ?
        `, [source, id]).then(resultList => resultList[0]);
    },

    add(firstName, lastName, email) {
        return db.query(`
            INSERT INTO Customer (
                first_name,
                last_name,
                email_address,
                is_admin
            ) VALUES (?, ?, ?, ?)
        `, [firstName, lastName, email, 0])
        .then(result => result.insertId);
    }
};

module.exports = customers;