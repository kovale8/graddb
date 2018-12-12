const router = require('express').Router();
const suppliers = require('../services/suppliers');

router.route('/add')
.get((req, res) => res.render('supplierAdd', {
    title: ': Add Supplier',
    hideStatus: true,
    formFields: [
        {key: 'name', label: 'Supplier Name'}
    ]
}))
.post((req, res) => {
    if (!req.body.name)
        return res.render('error', {text: 'Missing supplier name.'});
    suppliers.add(req.body.name)
    .then(supplierId => res.redirect(`./${supplierId}`));
});

router.route('/:id')
.get((req, res) => suppliers.get(req.params.id).then(supplier =>
    res.render('modify', {
        title: ': Supplier',
        hideStatus: true,
        header: 'Nile Supplier',
        formFields: [
            {key: 'name', label: 'Supplier Name', value: supplier.name}
        ],
        entity: supplier
    })))
.post((req, res) => {
    if (!req.body.name)
        return res.render('error', {text: 'Missing supplier name.'});
    suppliers.update(req.params.id, req.body.name)
    .then(() => res.redirect('/admin/suppliers'));
});

router.get('/delete/:id', (req, res) =>
    suppliers.remove(req.params.id)
    .then(() => res.redirect('/admin/suppliers'))
    .catch(e => res.render('error', {
        text: `
            This supplier cannot be deleted.
            They may still have products at this shop.
        `
    })));

module.exports = router;