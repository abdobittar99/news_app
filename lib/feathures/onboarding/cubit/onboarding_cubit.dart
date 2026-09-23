import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());
  final PageController pageController = PageController();

  void onboardingPage(int index) {
    if (index == 2) {
      emit(state.copyWith(currentIndex: index, islastPage: true));
    } else {
      emit(state.copyWith(currentIndex: index, islastPage: false));
    }
  }
}
