import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dataBox.dart';

class UserData extends ChangeNotifier {
  static final UserData _singleton = UserData._internal();
  factory UserData() {
    return _singleton;
  }

  UserData._internal();

  static User? get authData => FirebaseAuth.instance.currentUser;

  static bool get isGod =>
      FirebaseAuth.instance.currentUser?.email == 'sumit123210@gmail.com';

  bool _isDarkMode = Data.boolBox.get('isDarkMode', defaultValue: true) ?? true;
  bool _isLoggedIn = authData != null;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    Data.boolBox.put('isDarkMode', value);
    notifyListeners();
  }
}
