const customers = require('../services/customers');
const customerProducts = require('../services/customerProducts');
const router = require('express').Router();

function deleteUserCookie(res) {
    res.cookie('user', '', {
        // Set to an arbitrary time in the past.
        expires: new Date(Date.now() - 1000)
    });
}

router.get('/logout', (req, res) => {
    deleteUserCookie(res);
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
    if (req.body.email === 'admin')
        return res.redirect('/admin');

    customers.findByEmail(req.body.email)
    .then(customer => {
        if (customer)
            res.redirect(`/user/${customer.source}-${customer.id}`);
        else
            res.render('error', {
                text: 'No user with these login credentials exists.'
            });
    });
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
    if (!req.body.email || !req.body.first_name || !req.body.last_name)
        return res.render('error', {text: 'Missing information.'});
    customers.add(
        req.body.first_name,
        req.body.last_name,
        req.body.email
    ).then(customerId => res.redirect(`/user/Nile-${customerId}`));
});

router.get('/:source-:id', async (req, res) => {
    let customer = res.locals.user;

    if (!customer) {
        customer = await customers.get(req.params.source, req.params.id);
        res.cookie('user', `${customer.source}-${customer.id}`, {
            maxAge: 90000000
        });
    }

    res.render('user', {
        title: ': Your Account',
        hideStatus: true,
        customer
    });
});

router.get('/:customer/cart', (req, res) =>
    customerProducts.getShoppingCart(req.params.customer)
    .then(productList => res.render('shoppingCart', {
        title: 'Shopping Cart',
        products: productList
    })));

router.get('/:customer/cart/:action/:product', (req, res) => {
    const action = customerProducts[req.params.action];
    if (!action)
        return res.render('error', {text: 'Invalid user action.'});

    action(req.params.customer, req.params.product)
    .then(() => res.redirect(`/user/${req.params.customer}`));
});

router.get('/delete', (req, res) => {
    const user = res.locals.user;
    deleteUserCookie(res);
    customers.remove(user.id).then(() =>
        res.render('userDelete', {
            title: ': Account Deleted',
            hideStatus: true,
            user
        })
    );
});

router.route('/modify')
.get((req, res) => {
    const user = res.locals.user;
    res.render('userModify', {
        title: ': Update Info',
        formFields: [
            {
                key: 'first_name',
                label: 'First Name',
                value: user.firstName
            },
            {
                key: 'last_name',
                label: 'Last Name',
                value: user.lastName
            },
            {
                key: 'email',
                label: 'Email',
                value: user.emailAddress
            }
        ]
    });
})
.post((req, res) => {
    const userId = res.locals.user.id;
    customers.update(userId, {
        firstName: req.body.first_name,
        lastName: req.body.last_name,
        email: req.body.email
    }).then(() => res.redirect(`/user/Nile-${userId}`));
});

module.exports = router;
