import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';


import '../bloc/intro_bloc/intro_screen_bloc.dart';
import '../bloc/intro_bloc/intro_screen_bloc_event.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';
import 'page_view_model.dart';


class IntroScreen{
                                                        ///This is a page decoration for intro screen
  PageDecoration pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color:Colors.white
    ), //tile font size, weight and color
    bodyTextStyle:TextStyle(fontSize: 19.0, color:Colors.white),
    imagePadding: EdgeInsets.all(20), //image padding
    boxDecoration:BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.45, 0.95, 0.999],
        colors: [
          Colors.blue,
          Colors.purple,
          Colors.blueAccent,
          Colors.lightBlue,
        ],
      ),
    ), //show linear gradient background of page
  );

  Widget buildIntroScreen(BuildContext context){
    return IntroductionScreen(
      globalBackgroundColor: Colors.lightBlue.shade300,
      pages: [                                                 ///buildPageViewModel will generate pages for intro screen
        PageModelView().buildPageViewModel(IntroImages.image1),
        PageModelView().buildPageViewModel(IntroImages.image2),
        PageModelView().buildPageViewModel(IntroImages.image3),
      ],
      onDone: () => context.read<IntroScreenBloc>().add(CompletedIntroScreenEvent()), /// redirects to home page on done
      onSkip: () => context.read<IntroScreenBloc>().add(CompletedIntroScreenEvent()), /// redirects to home page on skip
      showSkipButton: true,
      dotsFlex: 0,
      nextFlex: 0,
      skip:  Text(IntroStrings.skip, style: const TextStyle(color: Colors.white),),
      next: const Icon(Icons.arrow_forward, color: Colors.white,),
      done:  Text(IntroStrings.gettingStarted, style: const TextStyle(
          fontWeight: FontWeight.w600, color:Colors.white
      ),),
      controlsPosition: const Position(left: 65,right: 60,bottom: -6),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0), //size of dots
        color: Colors.white, //color of dots
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(                           ///The shape of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

}