import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

const BASE_URL = "http://127.0.0.1:8000/dj-rest-auth/";

const initialState = {
    user: {},
    status: "idle",
    error: null,
};

export const userLogin = createAsyncThunk(
    "login/userLogin",
    async (credentials) => {
        // console.log(credentials);
        try {
            const response = await axios.post(BASE_URL + "login/", {
                username: credentials.username,
                password: credentials.password,
            });

            return response.data;
        } catch (err) {
            console.log(err);
        }
    }
);

const loginSlice = createSlice({
    name: "login",
    initialState,
    reducers: {},
    extraReducers(builder) {
        builder
            .addCase(userLogin.pending, (state, action) => {
                state.status = "loading";
            })
            .addCase(userLogin.fulfilled, (state, action) => {
                state.status = "succeeded";
                // console.log(action.payload);
                state.user = action.payload;
                let pay = action.payload;
                localStorage.setItem("Username", pay.user.username);
                localStorage.setItem("Token", pay.access_token);
                // console.log(state.user);
            })
            .addCase(userLogin.rejected, (state, action) => {
                state.status = "failed";
            });
    },
});

export default loginSlice.reducer;

export const currentUser = (state) => state.user;
export const currentUserToken = (state) => state.access_token;
export const userLoginStatus = (state) => state.status;
export const userLoginError = (state) => state.error;
