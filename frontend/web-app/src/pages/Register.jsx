import React, { useState, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { Link, Navigate } from "react-router-dom";
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

    const [user, setUser] = useState({
        username: "",
        email: "",
        password1: "",
        password2: "",
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

    const handleChange = (event) => {
        const { name, value, checked, type } = event.target;
        setUser((prevState) => {
            return {
                ...prevState,
                [name]: type === "checkbox" ? checked : value,
            };
        });
    };

    const handleSumbit = (event) => {
        event.preventDefault();
        // console.log(user);
        //axios post logic
        const data = new FormData(event.currentTarget);
        if (data.get("password1") == data.get("password2")) {
            try {
                setSignupStatus("pending");
                // dispatch(userLogin(user.username, user.password));
                let username = user.username;
                let email = user.email;
                let password1 = user.password1;
                let password2 = user.password2;
                dispatch(
                    userReg({ username, email, password1, password2 })
                ).unwrap();
                setUser({
                    username: "",
                    password: "",
                });
            } catch (err) {
                console.log(err);
            } finally {
                setSignupStatus("idle");
            }
        } else {
            console.log("Passords did not match! Try again");
            setSignupError("Passords did not match! Try again");
        }
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
                        Sign in
                    </Typography>
                    <Box
                        component="form"
                        onSubmit={handleSumbit}
                        noValidate
                        sx={{ mt: 1 }}
                    >
                        <TextField
                            margin="normal"
                            required
                            fullWidth
                            id="username"
                            label="Username"
                            name="username"
                            autoFocus
                        />
                        <TextField
                            margin="normal"
                            required
                            fullWidth
                            id="email"
                            label="Email"
                            name="email"
                            autoFocus
                        />
                        <TextField
                            margin="normal"
                            required
                            fullWidth
                            label="Password"
                            name="password1"
                            type="password"
                            id="password1"
                            autoFocus
                            autoComplete="current-password"
                        />
                        <TextField
                            margin="normal"
                            required
                            fullWidth
                            label="Confirm Password"
                            name="password2"
                            type="password"
                            id="password2"
                            autoFocus
                            autoComplete="current-password"
                        />
                        <FormControlLabel
                            control={
                                <Checkbox value="remember" color="primary" />
                            }
                            label="Remember me"
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
                                Sign up
                            </Button>
                        </div>

                        <Grid item>
                            <p>Already have an account with us? </p>
                            <MuiLink href="/login" variant="body2">
                                {"Sign in"}
                            </MuiLink>
                        </Grid>
                    </Box>
                </Box>
                <Copyright sx={{ mt: 8, mb: 4 }} />
            </Container>
        </ThemeProvider>
    );
};

export default Register;
