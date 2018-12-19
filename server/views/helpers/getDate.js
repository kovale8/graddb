const months = [
    'January', 
    'February', 
    'March', 
    'April', 
    'May', 
    'June',
    'July', 
    'August', 
    'September', 
    'October', 
    'November', 
    'December'
];

function getDate(date) {
    date = new Date(date);
    return `${months[date.getMonth()]} ${date.getDate()}, ${date.getFullYear()}`
}

module.exports = getDate;