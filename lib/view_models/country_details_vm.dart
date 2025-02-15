import 'package:flutter/material.dart';

class CountryDetailsVm extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
