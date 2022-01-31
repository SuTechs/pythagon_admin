import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Pythagon',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Text(
            'Hello! World',
            style: TextStyle(
              color: Colors.red,
              fontSize: 64,
            ),
          ),
        ),
      ),
    );
  }
}
