import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;
  bool islastPage = false;
  PageController pageController = PageController();

  void onboardingPage(int index) {
    currentIndex = index;
    if (currentIndex == 2) {
      islastPage = true;
    } else {
      islastPage = false;
    }
    notifyListeners();
  }
}
