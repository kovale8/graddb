const customers = require('../services/customers');
const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('homepage', {title: 'Online Shopping'});
});

router.get('/user/:source-:id', (req, res) => {
    customers.get(req.params.source, req.params.id)
    .then(customer => res.render('user', {
        title: ': Your Account',
        customer
    }));
});

router.route('/signup')
.get((req, res) => res.render('signup', {title: ': Sign Up'}))
.post((req, res) => {
    customers.add(
        req.body.first_name,
        req.body.last_name,
        req.body.email
    ).then(customerId => res.redirect(`/user/${customerId}`));
});

module.exports = router;
