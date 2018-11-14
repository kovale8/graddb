const format = {
    capitalize(string) {
        const words = string.split(' ');
        const caps = words.map(word =>
            word[0].toUpperCase() + word.slice(1));
        return caps.join(' ');
    },

    snakeToCamel(snake) {
        return snake.replace(/(_\w)/g, match =>
            match[1].toUpperCase());
    }
};

module.exports = format;
