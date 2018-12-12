function capitalize(string) {
    if (!string) return string;

    if (typeof string !== 'string') return string;

    string = string.toLowerCase();

    let words = string.split(' ');
    words = words .map(w => w[0].toUpperCase() + w.slice(1));

    return words.join(' ');
}

module.exports = capitalize;
