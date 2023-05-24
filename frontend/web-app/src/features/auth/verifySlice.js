import { createSlice } from "@reduxjs/toolkit";

const verificationSlice = createSlice({
    name: "verify",
    initialState: {
        isSuccessful: false,
    },
    reducers: {
        setSuccess: (state, action) => {
            // console.log(" The slice's payload: " + action.payload);
            state.isSuccessful = action.payload;
        },
    },
});

export const { setSuccess } = verificationSlice.actions;

export default verificationSlice.reducer;
