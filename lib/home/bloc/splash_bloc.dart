import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rahbarapp/home/bloc/splash_event.dart';
import 'package:rahbarapp/home/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashScreenInitial()) {
    on<AppStarted>((event, emit) {
      emit(SplashScreenNavigateToLogin());
    });

    Timer(Duration(seconds: 3), () {
      add(AppStarted());
    });
  }
}
