import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/collegeBloc.dart';
import 'package:pythagon_admin/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().catchError((e) {
    print('Firebase init error = $e');
  });

  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  runApp(MyApp());

  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'sumit123210@gmail.com', password: 'Pythagon@12345#');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CollegeBloc()),
        Provider<BuildContext>(create: (c) => c),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pythagon',
        theme: ThemeData(
          fontFamily: "Montserrat",
          // colorSchemeSeed: kActiveColor,
          useMaterial3: true,
          primarySwatch: _kActiveSwatch,
        ),
        home: HomeScreen(),
      ),
    );
  }

// void addCollege() async {
//   final c = College(
//     id: 'id',
//     name: 'name',
//     img: 'img',
//     subjectsIds: ['subjectsIds'],
//     visibility: 'visibility',
//     isActive: true,
//     createdAt: Timestamp.now(),
//     updatedAt: Timestamp.now(),
//   );
//
//   College.ref.doc(c.id).set(c);
// }
}

const MaterialColor _kActiveSwatch =
    MaterialColor(_activePrimaryValue, <int, Color>{
  50: Color(0xFFF0EAFE),
  100: Color(0xFFDACAFB),
  200: Color(0xFFC1A6F9),
  300: Color(0xFFA882F7),
  400: Color(0xFF9668F5),
  500: Color(_activePrimaryValue),
  600: Color(0xFF7B46F1),
  700: Color(0xFF703DEF),
  800: Color(0xFF6634ED),
  900: Color(0xFF5325EA),
});
const int _activePrimaryValue = 0xFF834DF3;
