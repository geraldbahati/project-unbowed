import React, { useState, useEffect, useCallback } from "react";
import { useSelector, useDispatch } from "react-redux";
import { motion } from "framer-motion";
import { Link, useNavigate, Navigate } from "react-router-dom";
import {
    Avatar,
    Button,
    TextField,
    Box,
    Typography,
    Container,
    InputAdornment,
} from "@mui/material";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import { LockPersonOutlined, Message } from "@mui/icons-material";

import { setSuccess } from "../features/auth/verifySlice";

const animationVariants = {
    hidden: {
        x: "50vw",
    },
    visible: {
        x: 0,
        transition: { type: "spring", duration: 2.5 },
    },
};

const theme = createTheme();

const Verify = () => {
    const navigate = useNavigate();
    const dispatch = useDispatch();

    const [error, setError] = useState("");
    const [status, setStatus] = useState("idle");

    const handleChange = (event) => {
        const { name, value, checked, type } = event.target;
        setUser((prevState) => {
            return {
                ...prevState,
                [name]: type === "checkbox" ? checked : value,
            };
        });
    };

    const handleSubmit = (e) => {
        e.preventDefault();

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
        //     setSignupError("The number entered is invalid. Try again");
        // }
        dispatch(setSuccess(false));
        navigate("/success");
        // return <Success isSuccessful={true} />;
    };

    return (
        <ThemeProvider theme={theme}>
            <Container>
                <motion.div
                    variants={animationVariants}
                    initial="hidden"
                    animate="visible"
                >
                    <Box
                        onSubmit={handleSubmit}
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
                                InputProps={{
                                    startAdornment: (
                                        <InputAdornment position="start">
                                            <Message />
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
                                    Verify
                                </Button>
                            </motion.div>
                        </Box>
                    </Box>
                </motion.div>
            </Container>
        </ThemeProvider>
    );
};

export default Verify;
