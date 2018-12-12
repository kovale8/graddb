const db = require('./db');

const fields = `
    product_id AS id,
    product_name AS name,
    product_description AS description,
    price,
    category,
    source_name AS source
`;

const products = {
    get(source, id) {
        return db.queryOne(`
            SELECT ${fields}
            FROM Product_View
            WHERE source_name = ? AND product_id = ?
        `, [source, id]);
    },

    getAll() {
        return db.query(`
            SELECT ${fields}
            FROM Product_View
            ORDER BY product_name ASC
        `);
    },

    getCategory(id) {
        return db.queryOne(`
            SELECT
                category_id AS id,
                category_name AS name
            FROM Category
            WHERE category_id = ?
        `, [id]);
    },

    getCategories() {
        return db.query(`
            SELECT
                category_id AS id,
                category_name AS name
            FROM Category
        `);
    },

    findByCategory(categoryId) {
        return db.query(`
            SELECT ${fields}
            FROM Product_View
            WHERE category_id = ?
        `, [categoryId]);
    }
};

module.exports = products;