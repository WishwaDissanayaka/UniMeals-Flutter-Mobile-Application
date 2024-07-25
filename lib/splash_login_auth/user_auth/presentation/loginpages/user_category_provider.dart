import 'package:flutter/material.dart';

class UserCategoryProvider with ChangeNotifier {
  String _userCategory = '';

  String get userCategory => _userCategory;

  void setUserCategory(String category) {
    _userCategory = category;
    notifyListeners();
  }
}
