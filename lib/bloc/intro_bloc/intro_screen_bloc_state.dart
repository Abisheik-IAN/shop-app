import 'package:equatable/equatable.dart';

abstract class IntroScreenState extends Equatable{
  const IntroScreenState();
}

class InitialState extends IntroScreenState{
  @override
  List<Object?> get props => [];
}

class ViewingIntroScreenState extends IntroScreenState{
  @override
  List<Object?> get props => [];
}

class CompletedIntroScreenState extends IntroScreenState{
  final String introScreenFlow;
  const CompletedIntroScreenState(this.introScreenFlow);
  @override
  List<Object?> get props => [introScreenFlow];
}

class LoadingState extends IntroScreenState{
  @override
  List<Object?> get props => [];
}