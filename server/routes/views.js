const customers = require('../services/customers');
const router = require('express').Router();

function deleteUserCookie(res) {
    res.cookie('user', '', {
        // Set to an arbitrary time in the past.
        expires: new Date(Date.now() - 1000)
    });
}

router.get('/', (req, res) => {
    res.render('homepage', {title: 'Online Shopping'});
});

router.get('/admin', (req, res) => {
    res.render('admin', {
        title: 'Admin',
        hideStatus: true,
        options: [
            'customers'
        ]
    });
});

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

router.get('/user/:source-:id', async (req, res) => {
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

router.get('/user/delete', (req, res) => {
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

router.route('/user/modify')
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
