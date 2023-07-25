import CryptoJS from "crypto-js";

const SECRET_KEY =
    "django-insecure-xcqxiw+#c6*yeb=*t!h0gi&b-(hogd$!5yvak2ytj3h*ittwnx";

// Function to encrypt user data
export const encryptData = (data) => {
    try {
        const encryptedData = CryptoJS.AES.encrypt(
            JSON.stringify(data),
            SECRET_KEY
        ).toString();
        return encryptedData;
    } catch (error) {
        console.error("Encryption error:", error);
        return null;
    }
};

// Function to decrypt user data
export const decryptData = (encryptedData) => {
    try {
        const bytes = CryptoJS.AES.decrypt(encryptedData, SECRET_KEY);
        const decryptedData = bytes.toString(CryptoJS.enc.Utf8);

        // Check if decryptedData is not empty
        if (decryptedData) {
            return JSON.parse(decryptedData);
        } else {
            console.error("Invalid decrypted data:", decryptedData);
            return null;
        }
    } catch (error) {
        console.error("Decryption error:", error);
        return null;
    }
};
