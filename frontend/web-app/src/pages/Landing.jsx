import React, { useState } from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";

import { CiCircleChevRight } from "react-icons/all";

import { HeroSlider } from "../components";
import "../styles/Landing.css";
import { imageData } from "../assets/data";

const Landing = () => {
    return (
        <div className="landing">
            <h2>Unbowed</h2>

            <HeroSlider />

            <motion.a
                href="/register"
                initial={{ scale: 1 }}
                whileHover={{
                    scale: 1.1,
                }}
            >
                <CiCircleChevRight
                    style={{ color: "#1A96DC", fontSize: "60px" }}
                />
            </motion.a>
        </div>
    );
};

export default Landing;
