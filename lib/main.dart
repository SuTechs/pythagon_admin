import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pythagon_admin/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().catchError((e) {
    print('Firebase init error = $e');
  });

  // CollectionRef.colleges.get().then((value) {
  //   print('data = ${value.docs.first.data()}');
  // });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pythagon',

        theme: ThemeData(fontFamily: "Montserrat"),
        home: HomeScreen());
  }
}
