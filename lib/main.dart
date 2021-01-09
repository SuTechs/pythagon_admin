import 'package:flutter/material.dart';
import 'package:pythagon_admin/screens/assignmentHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: const Color(0xffE5DDD5)),
      debugShowCheckedModeBanner: false,
      title: 'Pythagon',
      home: AssignmentHome(),
    );
  }
}
