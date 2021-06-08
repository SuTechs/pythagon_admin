import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dataBox.dart';

class UserData extends ChangeNotifier {
  /// singleton
  static final UserData _singleton = UserData._internal();

  factory UserData() {
    return _singleton;
  }

  UserData._internal();

  /// logics

  static User? get authData => FirebaseAuth.instance.currentUser;

  static bool get isGod =>
      FirebaseAuth.instance.currentUser?.email == 'sumit123210@gmail.com';

  late bool _isDarkMode =
      Data.boolBox.get('isVerified', defaultValue: true) ?? true;
  late bool _isLoggedIn =
      Data.boolBox.get('isLoggedIn', defaultValue: true) ?? true;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    Data.boolBox.put('isLoggedIn', value);
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    Data.boolBox.put('isVerified', value);
    notifyListeners();
  }
}
