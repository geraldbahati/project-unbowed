import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

const BASE_URL = "http://127.0.0.1:8000/dj-rest-auth/";

const initialState = {
    user: {},
    status: "idle",
    error: null,
};

export const userReg = createAsyncThunk(
    "login/userLogin",
    async (credentials) => {
        // console.log(credentials);
        try {
            const response = await axios.post(BASE_URL + "registration/", {
                username: credentials.username,
                email: credentials.email,
                password1: credentials.password1,
                password2: credentials.password2,
            });

            return response.data;
        } catch (err) {
            console.log(err);
        }
    }
);

const regSlice = createSlice({
    name: "login",
    initialState,
    reducers: {},
    extraReducers(builder) {
        builder
            .addCase(userReg.pending, (state, action) => {
                state.status = "loading";
            })
            .addCase(userReg.fulfilled, (state, action) => {
                state.status = "succeeded";
                // console.log(action.payload);
                state.user = action.payload;
                // console.log(state.user);
            })
            .addCase(userReg.rejected, (state, action) => {
                state.status = "failed";
            });
    },
});

export default regSlice.reducer;

export const userRegStatus = (state) => state.status;
export const userRegError = (state) => state.error;
