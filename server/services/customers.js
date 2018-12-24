const db = require('./db');

const customerFields = `
    customer_id AS id,
    source,
    first_name,
    last_name,
    email_address
`;

const customers = {
    get(source, id) {
        return db.queryOne(`
            SELECT ${customerFields}
            FROM Customer_View
            WHERE source = ? AND customer_id = ?
        `, [source, id]);
    },

    getAll() {
        return db.query(`
            SELECT ${customerFields}
            FROM Customer_View
            ORDER BY last_name ASC
            LIMIT 1000
        `);
    },

    getNonActive() {
        return db.query(`
            SELECT customer_id AS id
            FROM NotTooActive_Customers_Report_View
        `);
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
                email_address
            ) VALUES (?, ?, ?)
        `, [firstName, lastName, email]);
    },

    remove(id) {
        return db.query(`
            DELETE FROM Customer
            WHERE customer_id = ?
        `, [id]);
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
