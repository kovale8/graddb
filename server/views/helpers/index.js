const fs = require('fs');

function bind(hbs) {
    fs.readdirSync(__dirname)
        // Grab only js files.
        .filter(file => file !== 'index.js' && file.endsWith('.js'))
        // Remove the js endings.
        .map(file => file.slice(0, -3))
        // Register each function.
        .forEach(key => {
            const fn = require(`./${key}`);
            hbs.registerHelper(key, fn);
        });
}

module.exports = { bind };
