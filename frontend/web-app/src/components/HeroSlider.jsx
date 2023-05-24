import React from "react";
import { motion } from "framer-motion";

import Carousel from "./Carousel";
import "../styles/Slider.css";
import { imageData } from "../assets/data";
import GridView from "./GridView";

const HeroSlider = () => {
    return (
        <div className="">
            <Carousel>
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 2, delay: 2 }}
                >
                    <GridView />
                    <section className="slider__text">
                        <h1>Create Productive Work, Right Now</h1>
                        <p>
                            Collaborate, create and keep track of your project,
                            easily and effectively
                        </p>
                    </section>
                </motion.div>
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 4, delay: 3 }}
                >
                    <div className="slider__images">
                        <img
                            src={imageData[3].img}
                            alt={imageData[1].title}
                            style={{ maxWidth: "360px" }}
                        />
                    </div>

                    <section className="slider__text">
                        <h1>Your very own campus AI Assistant</h1>
                        <p>
                            Power up your school work with your very own AI Bot
                            at the palm of your hands.
                        </p>
                    </section>
                </motion.div>
            </Carousel>
        </div>
    );
};

export default HeroSlider;
