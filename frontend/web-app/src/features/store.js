import { configureStore } from "@reduxjs/toolkit";
import { decryptData } from "../utilities/encryption";

import loginReducer from "./auth/loginSlice";
import registerReducer from "./auth/signupSlice";
import logoutReducer from "./auth/logoutSlice";
import themeReducer from "./functionality/themeSlice.js";
import verificationReducer from "./auth/verifySlice";

// Check if encrypted user data exists in local storage
const encryptedUserData = localStorage.getItem("User");
let decryptedUser = null;

// If encrypted user data is found, decrypt it
if (encryptedUserData) {
    decryptedUser = decryptData(encryptedUserData);
}

const preloadedState = {
    login: {
        status: "idle",
        user: decryptedUser,
        theme: "light",
    },
    // Other reducers and their initial state (if any)
};

const store = configureStore({
    reducer: {
        login: loginReducer,
        register: registerReducer,
        logout: logoutReducer,
        theme: themeReducer,
        verify: verificationReducer,
    },
    preloadedState,
});

export default store;
