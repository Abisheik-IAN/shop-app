import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CaroselSlider extends StatefulWidget {
  final int indexValue;
  final double caroselheight;
  final List images;
  final bool sliderautoplay;
  final double viewportfraction;
  final bool infinitescroll;
  final bool enlargecenterimage;
  final int imageslideduration;
  final bool buttoncontroller;
  final Function(int) onCountChanged;
  final Function(GlobalKey<CarouselSliderState>) controller;

  const CaroselSlider(
      {Key? key,
      required this.indexValue,
        required this.caroselheight,
      required this.images,
      required this.enlargecenterimage,
      required this.imageslideduration,
      required this.infinitescroll,
      required this.sliderautoplay,
      required this.viewportfraction,
      required this.buttoncontroller,
      required this.onCountChanged,
      required this.controller})
      : super(key: key);

  @override
  CaroselSliderState createState() => CaroselSliderState();
}

int current = 0;

class CaroselSliderState extends State<CaroselSlider> {
  int activeIndex = 0;
  final controller = CarouselController();
  GlobalKey<CarouselSliderState> sliderKey = GlobalKey();

  int activePage = 1;
  @override
  Widget build(BuildContext context) {
    widget.controller(sliderKey);
    return Container(
      width: getDevicewidth(context, 1),
      child: CarouselSlider.builder(
          key: sliderKey,
          carouselController: controller,
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = widget.images[index];
            return buildImage(urlImage, index);
          },
          options: CarouselOptions(
            height: widget.caroselheight,
            initialPage: 0,
            autoPlay: widget.sliderautoplay,
            viewportFraction: widget.viewportfraction,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: widget.infinitescroll,
            autoPlayAnimationDuration:
                Duration(seconds: widget.imageslideduration),
            enlargeCenterPage: widget.enlargecenterimage,
            enlargeStrategy: widget.enlargecenterimage
                ? CenterPageEnlargeStrategy.height
                : CenterPageEnlargeStrategy.scale,
            onPageChanged: (index, reason) => setState(() {
              activeIndex = index;
              widget.onCountChanged(index);
            }),
          )),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              urlImage,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: widget.images.length,
      onDotClicked: animateToSlide,
      effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color.fromRGBO(56, 75, 49, 1.0),
          dotColor: Colors.black12),
    );
  }

  animateToSlide(int index) => controller.animateToPage(index);

  getDevicewidth(BuildContext context, double percentage) {
    var width = MediaQuery.of(context).size.width;
    double wid = width * percentage;

    return wid;
  }

  getDeviceheight(BuildContext context, double percentage) {
    var height = MediaQuery.of(context).size.height;
    double heg = height * percentage;

    return heg;
  }
}
