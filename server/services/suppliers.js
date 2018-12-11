const db = require('./db');

const fields = `
    supplier_id AS id,
    supplier_name AS name
`;

const suppliers = {
    get(id) {
        return db.queryOne(`
            SELECT ${fields}
            FROM Supplier
            WHERE supplier_id = ?
        `, [id]);
    },

    getAll() {
        return db.query(`
            SELECT ${fields}
            FROM Supplier
            ORDER BY supplier_name ASC
        `);
    },

    add(name) {
        return db.insert(`
            INSERT INTO Supplier (supplier_name)
            VALUES (?)
        `, [name]);
    },

    remove(id) {
        return db.query(`
            DELETE FROM Supplier
            WHERE supplier_id = ?
        `, [id]);
    }
};

module.exports = suppliers;