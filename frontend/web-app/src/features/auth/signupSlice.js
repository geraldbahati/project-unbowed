import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

const BASE_URL = "http://127.0.0.1:8000/api/user/";

const initialState = {
    user: {},
    status: "idle",
    error: null,
};

export const userReg = createAsyncThunk(
    "login/userLogin",
    async (credentials) => {
        try {
            const response = await axios.get(
                BASE_URL + `get_user_details/${credentials.phone_number}`
            );

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
                // console.log("Action payload is: " + action.payload);
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
