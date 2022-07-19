import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_screen_bloc_event.dart';
import 'intro_screen_bloc_state.dart';

class IntroScreenBloc extends Bloc<IntroScreenDispatchEvent,IntroScreenState>{
  IntroScreenBloc() : super(InitialState()){
    on<InitiateIntroScreenEvent>((event, emit)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var introScreenFlow = prefs.getString("introScreenFlow");
      if(introScreenFlow == "Done"){
        emit(CompletedIntroScreenState(introScreenFlow!));
      }else {
        emit(ViewingIntroScreenState());
      }                                /// To showcase the Intro Screen by emitting this state..
    });

    on<CompletedIntroScreenEvent>((event, emit)async{
      emit(LoadingState());                                /// Loader is emitted here..
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("introScreenFlow", "Done");
      var introScreenFlow = prefs.getString("introScreenFlow");
      await Future.delayed(const Duration(seconds: 2));
      emit(CompletedIntroScreenState(introScreenFlow!));                  ///  This state will provide navigation to application home screen..
    });


  }
}