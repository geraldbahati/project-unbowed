import React from "react";
import { motion } from "framer-motion";
import {
    BsExclamation,
    BsCircle,
    BsChatLeftText,
    BsFillCircleFill,
    BsChatRightTextFill,
} from "react-icons/all";

import "../styles/GridView.css";
import { imageData } from "../assets/data";
import image from "../assets/images/resizedImage.png";

const animationVariants = {
    hidden: {
        x: "50vw",
    },
    visible: {
        x: 0,
        transition: { type: "spring", duration: 2.5 },
    },
};

const GridView = () => {
    return (
        <div className="grid">
            <div className="grid__one">
                <motion.div
                    initial={{ scale: 1 }}
                    animate={{ scale: 3 }}
                    transition={{
                        type: "spring",
                        repeat: "infinity",
                        repeatType: "reverse",
                        duration: 4,
                    }}
                    style={{ margin: "0 auto" }}
                >
                    <BsExclamation />
                </motion.div>
            </div>
            <div className="grid__two">
                <img src={image} alt="" />
            </div>
            <div className="grid__three"></div>
            <div className="grid__four">4</div>
            <div className="grid__five">
                <motion.div
                    // initial={{ x: "-10vw",y:"" }}
                    animate={{
                        x: [0, 60],
                        y: ["0vh", "5vh"],
                    }}
                    transition={{
                        type: "spring",
                        repeat: "infinity",
                        repeatType: "reverse",
                        duration: 4,
                    }}
                >
                    <BsChatLeftText />
                </motion.div>
                <motion.div
                    animate={{
                        x: [8, -60],
                        y: ["5vh", "0vh"],
                    }}
                    transition={{
                        type: "spring",
                        repeat: "infinity",
                        repeatType: "reverse",
                        duration: 4,
                    }}
                >
                    <BsChatRightTextFill />
                </motion.div>
            </div>
            <div className="grid__six">6</div>
            <div className="grid__seven">7</div>
            <div className="grid__eight">
                <motion.div
                    animate={{
                        x: [-4, 30],
                    }}
                    transition={{
                        type: "spring",
                        repeat: "infinity",
                        duration: 4,
                    }}
                >
                    <BsCircle />
                </motion.div>
                <motion.div
                    animate={{
                        x: [4, -30],
                    }}
                    transition={{
                        type: "spring",
                        repeat: "infinity",
                        repeatType: "reverse",
                        duration: 4,
                    }}
                >
                    <BsFillCircleFill />
                </motion.div>
            </div>
        </div>
    );
};

export default GridView;
