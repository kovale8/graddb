const Entity = require('./entity');

class Customers extends Entity {

    constructor() {
        super('Customer_View');
    }
}

module.exports = new Customers();
