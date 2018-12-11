const db = require('./db');

const customerFields = `
    customer_id AS id,
    source,
    first_name,
    last_name,
    email_address,
    is_admin
`;

const customers = {
    get(source, id) {
        return db.queryOne(`
            SELECT ${customerFields}
            FROM Customer_View
            WHERE source = ? AND customer_id = ?
        `, [source, id]);
    },

    findByEmail(email) {
        return db.queryOne(`
            SELECT ${customerFields}
            FROM Customer_View
            WHERE email_address = ?
        `, [email]);
    },

    add(firstName, lastName, email) {
        return db.insert(`
            INSERT INTO Customer (
                first_name,
                last_name,
                email_address,
                is_admin
            ) VALUES (?, ?, ?, ?)
        `, [firstName, lastName, email, 0]);
    },

    update(id, newInfo) {
        return db.query(`
            UPDATE Customer
            SET
                first_name = ?,
                last_name = ?,
                email_address = ?
            WHERE customer_id = ?
        `, [
            newInfo.firstName,
            newInfo.lastName,
            newInfo.email,
            id
        ]);
    }
};

module.exports = customers;