const products = require('../services/products');
const router = require('express').Router();

router.get('/:source-:id', (req, res) =>
    products.get(req.params.source, req.params.id)
    .then(product => res.render('product', {
        title: `: ${product.name}`,
        product
    })));

module.exports = router;
