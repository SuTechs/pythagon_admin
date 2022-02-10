import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pythagon_admin/data/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().catchError((e) {
    print('Firebase init error = $e');
  });

  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  runApp(MyApp());

  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'sumit123210@gmail.com', password: 'Pythagon@12345#');
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
        floatingActionButton: FloatingActionButton(
          onPressed: addCollege,
        ),
      ),
    );
  }

  void addCollege() async {
    final c = College(
      id: 'id',
      name: 'name',
      img: 'img',
      subjectsIds: ['subjectsIds'],
      visibility: 'visibility',
      isActive: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    College.ref.doc(c.id).set(c);
  }
}
