import 'package:flutter/foundation.dart';
import 'dataBox.dart';

class User extends ChangeNotifier {
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  bool _isDarkMode;

  void init() {
    _isDarkMode = Data.boolBox.get('isVerified', defaultValue: false);
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    Data.boolBox.put('isVerified', value);
    notifyListeners();
  }
}
