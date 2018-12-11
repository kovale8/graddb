const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('admin', {
        title: 'Admin',
        hideStatus: true,
        options: [
            'customers'
        ]
    });
});

module.exports = router;