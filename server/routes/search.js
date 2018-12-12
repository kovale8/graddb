const products = require('../services/products');
const router = require('express').Router();

router.get('/', async (req, res) => {
    const category = await products.getCategory(req.query.category);
    if (!category)
        return res.render('error', {text: 'Invalid search criteria.'});

    const productList = await products.findByCategory(category.id);

    res.render('search', {
        title: ': Search Products',
        search: category.name,
        products: productList
    })
});

module.exports = router;