import 'package:flutter/material.dart';

class MyBottomNavBarViewModel extends ChangeNotifier {
  int currentIndex = 0;

  void selectedTab(int index, BuildContext context) {
    setCurrentIndex(index);
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
