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

import { userReg } from "../features/auth/signupSlice";
import { userRegStatus } from "../features/auth/signupSlice";
import { userRegError } from "../features/auth/signupSlice";

const Copyright = (props) => {
    return (
        <Typography
            variant="body2"
            color="text.secondary"
            align="center"
            {...props}
        >
            {"Copyright Wizzbeats ©"}
            <MuiLink color="inherit" href="#">
                WizzBeats
            </MuiLink>
            {new Date().getFullYear()}
            {"."}
        </Typography>
    );
};

const theme = createTheme();

const Register = () => {
    const dispatch = useDispatch();

    const navigate = useNavigate();

    const [user, setUser] = useState({
        phone: "",
    });

    const [signupError, setSignupError] = useState("");
    const [signupStatus, setSignupStatus] = useState("idle");

    const AlertDisplay = () => {
        return (
            <Alert severity="error">
                <AlertTitle>Registration Error</AlertTitle>
                {signupError}
            </Alert>
        );
    };

    const formatPhoneNumber = useCallback(() => {
        if (!phone.startsWith("+254")) {
            setUser({
                phone: "+254" + user.phone,
            });
        }
    }, [user.phone]);

    //

    const handleChange = (event) => {
        const { name, value, checked, type } = event.target;
        setUser((prevState) => {
            return {
                ...prevState,
                [name]: type === "checkbox" ? checked : value,
            };
        });
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        const data = new FormData(event.currentTarget);
        // if (data.get("phone")) {
        //     try {
        //         setSignupStatus("pending");

        //         let phone = user.phone;
        //         dispatch(userReg({ phone })).unwrap();
        //         setUser({
        //             phone: "",
        //         });
        //     } catch (err) {
        //         console.log(err);
        //     } finally {
        //         setSignupStatus("idle");
        //     }
        // } else {
        //     console.log("The number entered is invalid. Try again");
        //     setSignupError("The number entered is invalid. Try again");
        // }
        navigate("/verification");
    };

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
                        Sign Up
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
                            Enter your phone number
                        </Typography>
                        <TextField
                            margin="normal"
                            type="number"
                            required
                            fullWidth
                            id="phone"
                            label="Phone Number"
                            name="phone"
                            autoFocus
                            onFocus={formatPhoneNumber}
                            onBlur={formatPhoneNumber}
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
                                Next
                            </Button>
                        </div>

                        <Grid
                            item
                            sx={{
                                display: "flex",
                                flexDirection: "column",
                                justifyContent: "space between",
                                alignItems: "center",
                                position: "absolute",
                                bottom: 20,
                            }}
                        >
                            <p>Already have an account with us? </p>
                            <MuiLink href="/login" variant="body2">
                                {"Sign in"}
                            </MuiLink>
                        </Grid>
                    </Box>
                </Box>
            </Container>
        </ThemeProvider>
    );
};

export default Register;
