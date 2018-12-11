function getCustomerId(customer) {
    return [customer.source, customer.id].join('-');
}

module.exports = getCustomerId;