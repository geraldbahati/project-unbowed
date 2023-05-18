import React from "react";
import {
    ImageList,
    ImageListItem,
    ImageListItemBar,
    IconButton,
} from "@mui/material/";
import Carousel from "react-material-ui-carousel";

import { imageData } from "../assets/data";

const HeroSlider = () => {
    return (
        <div className="">
            <Carousel style={{ overflow: "visible", width: "auto" }}>
                <div>
                    <div className="slider__images">
                        <img
                            src={imageData[2].img}
                            alt={imageData[2].title}
                            style={{
                                maxHeight: "320px",
                            }}
                        />
                    </div>

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
            {/* <Carousel sx={{ maxWidth: "480px" }}>
                <img
                    src={imageData[1].img}
                    alt=""
                    style={{ maxHeight: "480px" }}
                />
                <img
                    src={imageData[2].img}
                    alt=""
                    style={{ maxHeight: "480px" }}
                />
            </Carousel> */}
        </div>
    );
};

export default HeroSlider;

{
    /* <img
                        src={imageData[1].img}
                        alt=""
                        style={{ maxHeight: "480px" }}
                    /> */
}

{
    /*
    <div className="slider__images">
                        <ImageList
                            rowHeight={200}
                            gap={1}
                            className="slider__imageList"
                        >
                            {imageData.map((item) => (
                                <ImageListItem
                                    key={item.img}
                                    cols={1}
                                    rows={1}
                                    className="slider__imageListItem"
                                >
                                    <img src={item.img} alt={item.title} />
                                </ImageListItem>
                            ))}
                        </ImageList>

                        
                    </div>

                    <section className="slider__text">
                        <h1>Create Productive Work, Right Now</h1>
                        <p>
                            Collaborate, create and keep track of your project,
                            easily and effectively
                        </p>
                    </section>
    */
    /**
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
    */
}
