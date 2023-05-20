import React, { useState } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";

import { CiCircleChevRight } from "react-icons/all";

import { HeroSlider, Carousel } from "../components";
import "../styles/Landing.css";
import { imageData } from "../assets/data";

const Landing = () => {
    return (
        <motion.div className="landing">
            <motion.h2
                initial={{ y: "-50vh", opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ duration: 2 }}
            >
                Unbowed
            </motion.h2>

            <HeroSlider />

            <motion.a
                href="/register"
                initial={{ scale: 1, y: "100vh", opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ duration: 2 }}
                whileHover={{
                    scale: 1.1,
                }}
            >
                <CiCircleChevRight
                    style={{ color: "#1A96DC", fontSize: "60px" }}
                />
            </motion.a>
        </motion.div>
    );
};

export default Landing;
