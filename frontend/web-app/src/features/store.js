import { configureStore } from "@reduxjs/toolkit";

import loginReducer from "./auth/loginSlice";
import registerReducer from "./auth/signupSlice";
import logoutReducer from "./auth/logoutSlice";
import themeReducer from "./functionality/themeSlice.js";
import verificationReducer from "./auth/verifySlice";

const store = configureStore({
    reducer: {
        login: loginReducer,
        register: registerReducer,
        logout: logoutReducer,
        theme: themeReducer,
        verify: verificationReducer,
    },
});

export default store;
