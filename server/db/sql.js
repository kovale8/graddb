const fs = require('fs');
const ini = require('ini');
const mysql = require('mysql');
const os = require('os');
const path = require('path');

const confFile = path.join(os.homedir(), '.my.cnf');
const config = ini.parse(fs.readFileSync(confFile, 'utf8')).client;

const pool = mysql.createPool({
    host: config.host,
    user: config.user,
    password: config.password,

    connectionLimit: 10,
    database: 'nile'
});

const fn = {
    query(sql) {
        return new Promise(resolve => {
            pool.query(sql, (error, results) => {
                if (error) console.log(error.stack);
                else resolve(results);
            });
        });
    },

    queryOne(sql) {
        return this.query(sql).then(results => results[0]);
    }
};

module.exports = fn;
