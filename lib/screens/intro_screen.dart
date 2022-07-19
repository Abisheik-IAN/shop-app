import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/intro_bloc/intro_screen_bloc.dart';
import '../bloc/intro_bloc/intro_screen_bloc_state.dart';
import '../widgets/intro_screen_widget.dart';
import 'bottom_navigation_bar.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({Key? key}) : super(key: key);

  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: BlocBuilder<IntroScreenBloc, IntroScreenState>(
     builder: (context,state){
       if(state is LoadingState){
         return const Center(child: CircularProgressIndicator(),);
       }else
       if((state is InitialState) || (state is ViewingIntroScreenState)){
         return IntroScreen().buildIntroScreen(context);
       }else
         if(state is CompletedIntroScreenState){
           return const BottomNavigation();
         }else{
           return const Center(child: Text("Error Occurred.."),);
         }
     },
   ),
    );
  }

}
