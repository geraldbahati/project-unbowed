import { createSlice } from "@reduxjs/toolkit";
import { useSelector } from "react-redux";

import { currentUser } from "./loginSlice";

const initialState = {};

const logoutSlice = createSlice({
    name: "logout",
    initialState,
    reducers: {
        logout: {
            reducer(state, action) {
                localStorage.removeItem("Username");
                localStorage.removeItem("Token");
                console.log("Action received!");
            },
        },
    },
});

export const { logout } = logoutSlice.actions;

export default logoutSlice.reducer;
