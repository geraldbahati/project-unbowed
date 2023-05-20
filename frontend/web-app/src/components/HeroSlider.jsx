import React from "react";

import Carousel from "./Carousel";
import "../styles/Slider.css";
import { imageData } from "../assets/data";
import GridView from "./GridView";

const HeroSlider = () => {
    return (
        <div className="">
            <Carousel>
                <div>
                    <GridView />
                    <section className="slider__text">
                        <h1>Create Productive Work, Right Now</h1>
                        <p>
                            Collaborate, create and keep track of your project,
                            easily and effectively
                        </p>
                    </section>
                </div>
                <div>
                    <div className="slider__images">
                        <img
                            src={imageData[1].img}
                            alt={imageData[1].title}
                            style={{
                                maxHeight: "320px",
                            }}
                        />
                    </div>

                    <section className="slider__text">
                        <h1>Your very own campus AI Assistant</h1>
                        <p>
                            Power up your school work with your very own AI Bot
                            at the palm of your hands.
                        </p>
                    </section>
                </div>
            </Carousel>
        </div>
    );
};

export default HeroSlider;
