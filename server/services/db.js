const mysql = require('mysql');

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectionLimit: 10,
    multipleStatements: true
});

function formatKeys(rows) {
    if (!(rows instanceof Array))
        return rows;

    return rows.map(row => {
        const newRow = {};
        const keys = Object.keys(row);
        keys.forEach(key => {
            const newKey = key.replace(/(_\w)/g, match =>
                match[1].toUpperCase());
            newRow[newKey] = row[key];
        });
        return newRow;
    });
}

const fn = {
    insert(sql, values) {
        return this.query(sql, values).then(result => result.insertId);
    },

    query(sql, values) {
        return new Promise((resolve, reject) => {
            pool.query(sql, values, (error, results) => {
                if (error) reject(error);
                else resolve(formatKeys(results));
            });
        });
    },

    queryOne(sql, values) {
        return this.query(sql, values).then(resultList => resultList[0]);
    }
};

module.exports = fn;
