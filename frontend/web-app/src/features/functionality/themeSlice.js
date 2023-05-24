import { createSlice } from "@reduxjs/toolkit";

const initialState = {
    background: "white",
    color: "red",
};

const themeSlice = createSlice({
    name: "theme",
    initialState,
    reducers: {
        setBackground: (state, action) => {
            state.background = action.payload;
        },
        setColor: (state, action) => {
            state.color = action.payload;
        },
    },
});

export const { setBackground, setColor } = themeSlice.actions;

export default themeSlice.reducer;
