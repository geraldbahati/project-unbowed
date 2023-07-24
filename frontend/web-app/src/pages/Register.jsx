import React, { useState, useEffect, useCallback } from "react";
import { useSelector, useDispatch } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import {
    Avatar,
    Alert,
    Button,
    TextField,
    Link as MuiLink,
    Grid,
    Box,
    Typography,
    InputAdornment,
    Container,
    AlertTitle,
} from "@mui/material";
import { createTheme, ThemeProvider } from "@mui/material/styles";

import { LockPersonOutlined, Phone } from "@mui/icons-material";

import { userReg } from "../features/auth/signupSlice";
import { userRegStatus } from "../features/auth/signupSlice";
import { userRegError } from "../features/auth/signupSlice";

const theme = createTheme();

// const useStyles = makeStyles({
//     root: {
//         "& .MuiInputBase-input": {
//             width: "150%", // Set the width to 100%
//             boxSizing: "border-box", // Ensure padding and border are included in the width
//         },
//     },
// });

const animationVariants = {
    hidden: {
        x: "50vw",
    },
    visible: {
        x: 0,
        transition: { type: "spring", duration: 2.5 },
    },
};

const Register = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const [user, setUser] = useState({ phone_number: "" });

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
        if (data.get("phone")) {
            try {
                setSignupStatus("pending");

                let phone_number = data.get("phone");
                dispatch(userReg({ phone_number })).unwrap();
                setUser({
                    phone: "",
                });
                // navigate("/verification");
            } catch (err) {
                console.log(err);
            } finally {
                setSignupStatus("idle");
            }
        } else {
            console.log("The number entered is invalid. Try again");
            setSignupError("The number entered is invalid. Try again");
        }

        // navigate("/verification");
    };

    return (
        <ThemeProvider theme={theme}>
            <Container sx={{ height: "100vh", width: "100vw" }}>
                <motion.div
                    // variants={animationVariants}
                    // initial="hidden"
                    // animate="visible"
                    style={{
                        marginTop: 8,
                        marginBottom: 4,
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
                            id="phone"
                            label="Phone Number"
                            name="phone"
                            type="number"
                            required
                            margin="normal"
                            size="small"
                            autoFocus
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <Phone />
                                    </InputAdornment>
                                ),
                            }}
                        />

                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 3 }}
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
                        </motion.div>
                    </Box>
                </motion.div>
                {/* <motion.div
                    style={{
                        display: "flex",
                        flexDirection: "column",
                        justifyContent: "center",
                        alignItems: "center",
                        position: "absolute",
                        bottom: 20,
                    }}
                >
                    <p>Already have an account with us? </p>
                    <a href="/login">Sign in</a>
                </motion.div> */}
            </Container>
        </ThemeProvider>
    );
};

export default Register;
