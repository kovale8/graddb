const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('home', {name: 'world'});
});

module.exports = router;
