import React, { useState, useEffect, useCallback } from "react";
import { useSelector, useDispatch } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import {
    Avatar,
    Alert,
    Button,
    CssBaseline,
    TextField,
    FormControlLabel,
    Checkbox,
    Link as MuiLink,
    Grid,
    Box,
    Typography,
    Container,
    AlertTitle,
} from "@mui/material";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import { LockPersonOutlined } from "@mui/icons-material";

const theme = createTheme();

const Verify = () => {
    const handleSubmit = (e) => {};

    return (
        <ThemeProvider theme={theme}>
            <Container>
                <CssBaseline />
                <Box
                    sx={{
                        marginTop: 8,
                        display: "flex",
                        flexDirection: "column",
                        alignItems: "center",
                    }}
                >
                    <Avatar sx={{ m: 1, bgcolor: "primary.main" }}>
                        <LockPersonOutlined />
                    </Avatar>
                    <Typography component="h1" variant="h5">
                        Verification
                    </Typography>
                    <Box
                        component="form"
                        onSubmit={handleSubmit}
                        noValidate
                        sx={{ mt: 1 }}
                    >
                        <Typography
                            component="h6"
                            variant="h6"
                            sx={{
                                mt: 2,
                                mb: 2,
                            }}
                        >
                            Enter the verification code sent.
                        </Typography>
                        <TextField
                            margin="normal"
                            type="number"
                            required
                            fullWidth
                            id="code"
                            label="Code"
                            name="code"
                            autoFocus
                        />

                        <div
                            style={{
                                display: "flex",
                                alignItems: "center",
                                justifyContent: "center",
                                margin: "5px 0",
                            }}
                        >
                            <Button
                                type="submit"
                                variant="contained"
                                sx={{ mt: 3, mb: 2 }}
                            >
                                Verify
                            </Button>
                        </div>
                    </Box>
                </Box>
            </Container>
        </ThemeProvider>
    );
};

export default Verify;
