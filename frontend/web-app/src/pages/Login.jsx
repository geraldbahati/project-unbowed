import React, { useState, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { Link, Navigate, useNavigate } from "react-router-dom";
import {
    Avatar,
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
} from "@mui/material";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import { LockPersonOutlined } from "@mui/icons-material";

import { userLogin } from "../features/auth/loginSlice";
import { userLoginStatus } from "../features/auth/loginSlice";
import { userLoginError } from "../features/auth/loginSlice";

const Copyright = (props) => {
    return (
        <Typography
            variant="body2"
            color="text.secondary"
            align="center"
            style={{ bottom: 0 }}
            {...props}
        >
            {"Copyright Unbowed ©"}
            <MuiLink
                color="inherit"
                href="#"
                style={{ textDecoration: "none" }}
            >
                Wizzoh
            </MuiLink>{" "}
            {new Date().getFullYear()}
            {"."}
        </Typography>
    );
};

const theme = createTheme();

const Login = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const [user, setUser] = useState({
        username: "",
        password: "",
    });

    const [loginError, setLoginError] = useState("");
    const [loginStatus, setLoginStatus] = useState("idle");

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

        //axios post logic
        const data = new FormData(event.currentTarget);
        try {
            setLoginStatus("pending");
            // dispatch(userLogin(user.username, user.password));
            let username = data.get("username");
            let password = data.get("password");
            dispatch(userLogin({ username, password })).unwrap();
            setUser({
                username: "",
                password: "",
            });
            const reNav = setTimeout(() => {
                navigate("/");
            }, 2000);
        } catch (err) {
            console.log(err);
        } finally {
            setLoginStatus("idle");
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
                        Hello, Welcome Back
                    </Typography>
                    <p style={{ textAlign: "center", padding: "5px 0" }}>
                        Happy to see you again, to use your account please login
                        first.
                    </p>
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
                            label="Password"
                            name="password"
                            type="password"
                            id="password"
                            autoFocus
                            autoComplete="current-password"
                        />
                        <div
                            style={{
                                display: "flex",
                                justifyContent: "space-between",
                                alignItems: "center",
                            }}
                        >
                            <FormControlLabel
                                control={
                                    <Checkbox
                                        value="remember"
                                        color="primary"
                                    />
                                }
                                label="Remember me"
                            />
                            <MuiLink href="/register" variant="body2">
                                {"Forgot Password"}
                            </MuiLink>
                        </div>
                        <div
                            style={{
                                display: "flex",
                                alignItems: "center",
                                justifyContent: "center",
                                margin: "10px 0",
                            }}
                        >
                            <Button
                                type="submit"
                                variant="contained"
                                style={{
                                    margin: "3px 0",
                                    alignSelf: "center",
                                }}
                            >
                                Sign in
                            </Button>
                        </div>

                        <Grid item style={{ textAlign: "center" }}>
                            <p>Don't have an account? </p>
                            <MuiLink href="/register" variant="body2">
                                {"Sign up"}
                            </MuiLink>
                        </Grid>
                    </Box>
                </Box>
                {/* <Copyright sx={{ mt: 8, mb: 4 }} /> */}
            </Container>
        </ThemeProvider>
    );
};

export default Login;
