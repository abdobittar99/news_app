import 'package:flutter/material.dart';

mixin SafeNotifi on ChangeNotifier {
  bool isDispose = false;

  void safeNotifi() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
