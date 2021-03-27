import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: "$message",
    timeInSecForIosWeb: 3,
    // webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
  );
}
