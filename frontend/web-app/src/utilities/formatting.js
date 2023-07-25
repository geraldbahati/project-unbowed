export const formatString = (inputString) => {
    // Convert the string to lowercase
    const lowerCaseString = inputString.toLowerCase();

    // Capitalize the first letter
    const capitalizedString =
        lowerCaseString.charAt(0).toUpperCase() + lowerCaseString.slice(1);

    // Add a space between any number and the surrounding characters
    const formattedString = capitalizedString
        .replace(/(\D)(\d)/g, "$1 $2")
        .replace(/(\d)(\D)/g, "$1 $2");

    return formattedString;
};
