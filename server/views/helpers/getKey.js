function getKey(entity) {
    return `${entity.source}-${entity.id}`;
}

module.exports = getKey;