const router = require('express').Router();
const views = require('./views');

router.use('/', views);

module.exports = router;
