import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dataBox.dart';

class UserData extends ChangeNotifier {
  static final UserData _singleton = UserData._internal();
  static User? get authData => FirebaseAuth.instance.currentUser;

  static bool get isGod =>
      FirebaseAuth.instance.currentUser?.email == 'sumit123210@gmail.com';

  factory UserData() {
    return _singleton;
  }

  UserData._internal();

  late bool _isDarkMode;

  void init() {
    _isDarkMode = Data.boolBox.get('isVerified', defaultValue: true) ?? true;
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    Data.boolBox.put('isVerified', value);
    notifyListeners();
  }
}
