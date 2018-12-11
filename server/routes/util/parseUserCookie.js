const customers = require('../../services/customers');

function parseUserCookie(req, res, next) {
    const userCookie = req.cookies.user;
    if (!userCookie)
        return next();

    const id = userCookie.split('-');
    customers.get(id[0], id[1])
    .then(customer => {
        if (customer)
            res.locals.user = customer;
        next();
    });
}

module.exports = parseUserCookie;