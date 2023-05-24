import React, { useState, useEffect } from "react";
import { ClipLoader } from "react-spinners";
import { motion } from "framer-motion";

const draw = {
    hidden: { pathLength: 0, opacity: 0 },
    visible: (i) => {
        const delay = 1 + i * 0.5;
        return {
            pathLength: 1,
            opacity: 1,
            transition: {
                pathLength: { delay, type: "spring", duration: 1.5, bounce: 0 },
                opacity: { delay, duration: 0.01 },
            },
        };
    },
};

const LoadingSpinner = () => {
    return (
        <motion.div>
            <ClipLoader
                color={"#1300ff"}
                loading={true}
                size={300}
                aria-label="Loading Spinner"
                data-testid="loader"
            />
        </motion.div>
    );
};

export default LoadingSpinner;

{
    /* <motion.svg
                width="600"
                height="600"
                viewBox="0 0 600 600"
                initial="hidden"
                animate="visible"
            >
                <motion.circle
                    cx="100"
                    cy="100"
                    r="80"
                    stroke="#ff0055"
                    variants={draw}
                    custom={1}
                />

                <motion.circle
                    cx="100"
                    cy="300"
                    r="80"
                    stroke="#0099ff"
                    variants={draw}
                    custom={2}
                />

                <motion.circle
                    cx="100"
                    cy="500"
                    r="80"
                    stroke="#00cc88"
                    variants={draw}
                    custom={3}
                />
            </motion.svg> */
}
