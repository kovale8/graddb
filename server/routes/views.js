const db = require('../db');
const router = require('express').Router();

router.get('/', (req, res) => {
    db.queryOne(`
        SELECT *
        FROM customer
        WHERE customer_id = 1
    `).then(results => {
        const user = results;
        res.render('home', {
            name: user.first_name,
            fullName: user.first_name + ' ' + user.last_name,
            email: user.email_address,
            phone: user.phone_number
        });
    });
});

module.exports = router;
