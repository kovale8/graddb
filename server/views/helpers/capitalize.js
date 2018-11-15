function capitalize(...strArgs) {
    // Discard the options object.
    strArgs.pop();
    // Flatten the arguments into a single string.
    const string = strArgs.join(' ');

    // Split the string into individual words.
    const words = string.split(' ');

    // Capitalize each word.
    const caps = words.map(word =>
        word[0].toUpperCase() + word.slice(1));

    // Return a single string.
    return caps.join(' ');
}

module.exports = capitalize;
