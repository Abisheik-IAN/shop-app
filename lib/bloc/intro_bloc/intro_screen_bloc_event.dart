import 'package:equatable/equatable.dart';

abstract class IntroScreenDispatchEvent extends Equatable{
  const IntroScreenDispatchEvent();
}

class InitiateIntroScreenEvent extends IntroScreenDispatchEvent{
  @override
  List<Object?> get props => [];
}

class CompletedIntroScreenEvent extends IntroScreenDispatchEvent{
  @override
  List<Object?> get props => [];
}
