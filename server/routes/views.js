const customers = require('../services/customers');
const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('homepage', {title: 'Online Shopping'});
});

router.get('/logout', (req, res) => {
    // Delete the user cookie.
    res.cookie('user', '', {expires: new Date(Date.now() - 1000)});
    res.render('logout', {title: ': Goodbye', hideStatus: true});
});

router.route('/signin')
.get((req, res) => res.render('signin', {
    title: ': Sign In',
    formFields: [
        {key: 'email', label: 'Email'}
    ]
}))
.post((req, res) => {
    customers.findByEmail(req.body.email)
    .then(customer =>
        res.redirect(`/user/${customer.source}-${customer.id}`));
});

router.route('/signup')
.get((req, res) => res.render('signup', {
    title: ': Sign Up',
    formFields: [
        {key: 'first_name', label: 'First Name'},
        {key: 'last_name', label: 'Last Name'},
        {key: 'email', label: 'Email'}
    ]
}))
.post((req, res) => {
    customers.add(
        req.body.first_name,
        req.body.last_name,
        req.body.email
    ).then(customerId => res.redirect(`/user/Nile-${customerId}`));
});

router.get('/user/:source-:id', (req, res) => {
    customers.get(req.params.source, req.params.id)
    .then(customer => {
        res.cookie('user', `${customer.source}-${customer.id}`, {
            maxAge: 90000000,
            httpOnly: true
        });
        res.render('user', {
            title: ': Your Account',
            hideStatus: true,
            customer
        });
    });
});

module.exports = router;
