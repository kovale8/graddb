const db = require('./db');

class Entity {

    constructor(table, processFn) {
        this.table = table;
        this.processFn = processFn;
    }

    get(id) {
        return this.query(`
            SELECT *
            FROM ${this.table}
            WHERE id = ?
        `, [id]).then(resultList => resultList[0]);
    }

    getAll() {
        return this.query(`
            SELECT *
            FROM ${this.table}
        `);
    }

    query(sql, values) {
        return db.query(sql, values)
        .then(resultList => {
            if (this.processFn)
                this.processFn(resultList);
            return resultList;
        });
    }
}

module.exports = Entity;
