import { configureStore } from "@reduxjs/toolkit";

import loginReducer from "./auth/loginSlice";
import registerReducer from "./auth/signupSlice";
import logoutReducer from "./auth/logoutSlice";
import themeReducer from "./auth/themeSlice.js";

const store = configureStore({
    reducer: {
        login: loginReducer,
        register: registerReducer,
        logout: logoutReducer,
        theme: themeReducer,
    },
});

export default store;
