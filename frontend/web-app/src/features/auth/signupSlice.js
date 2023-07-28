import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import axios from "axios";

import { encryptData, decryptData } from "../../utilities/encryption";
import { BASEURL } from "../../assets/urls";

const initialState = {
    user: {},
    status: "idle",
    error: null,
};

export const userReg = createAsyncThunk(
    "signup/usersignup",
    async (credentials) => {
        try {
            const response = await axios.get(
                BASEURL + `user/check-session/${credentials.phone_number}`
            );

            return response.data;
        } catch (err) {
            console.log(err);
        }
    }
);

const regSlice = createSlice({
    name: "register",
    initialState,
    reducers: {},
    extraReducers(builder) {
        builder
            .addCase(userReg.pending, (state, action) => {
                state.status = "loading";
            })
            .addCase(userReg.fulfilled, (state, action) => {
                state.status = "succeeded";
                // console.log("Login slice payload: " + action.payload);
                state.user = action.payload;

                // Encrypt user data before saving to local storage
                const encryptedUser = encryptData(action.payload);
                localStorage.setItem("User", encryptedUser);
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
