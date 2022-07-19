import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/app_strings.dart';
import 'intro_screen_widget.dart';

class PageModelView{
                                                      /// PageViewModel widget will generate pages
  PageViewModel buildPageViewModel(String imageUrl){
    return PageViewModel(
      title: IntroStrings.shopApp,
      body: IntroStrings.content,
      image: Align(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(imageUrl,)),
        alignment: Alignment.bottomCenter,
      ),
      decoration: IntroScreen().pageDecoration,
    );
  }
}