const format = {
    capitalize(string) {
        const words = string.split(' ');
        const caps = words.map(word =>
            word[0].toUpperCase() + word.slice(1));
        return caps.join(' ');
    }
};

module.exports = format;
