import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'data/bloc/assignmentListBloc.dart';
import 'data/bloc/currentAssignmentBloc.dart';
import 'data/utils/modal/user.dart';
import 'screens/assignmentHome.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<bool>('bool');
  // await Hive.openBox<String>('string');
  // await Hive.openBox<double>('double');
  // await Hive.openBox<int>('int');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => CurrentAssignmentBloc()),
        ChangeNotifierProvider(create: (_) => AssignmentListBloc()),
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: Provider.of<UserData>(context).isDarkMode
              ? ThemeData.dark()
                  .copyWith(scaffoldBackgroundColor: kDarkModeBackgroundColor)
              : ThemeData.light()
                  .copyWith(scaffoldBackgroundColor: kLightModeBackgroundColor),
          debugShowCheckedModeBanner: false,
          title: 'Pythagon',

          home: Provider.of<UserData>(context).isLoggedIn
              ? AssignmentHome()
              : AdminLogin(),

          // home: StreamBuilder<User?>(
          //     stream: FirebaseAuth.instance.userChanges(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         print('Error = ${snapshot.error}');
          //       }
          //
          //       // if (snapshot.connectionState == ConnectionState.waiting)
          //       //   return Center(child: CircularProgressIndicator());
          //
          //       print(
          //           'Snapshot has data = ${snapshot.hasData} and data = ${snapshot.data}');
          //
          //       if (snapshot.hasData) {
          //         if (snapshot.data != null) return AssignmentHome();
          //         return AdminLogin();
          //       }
          //
          //       return Center(child: CircularProgressIndicator());
          //     }),
        );
      },
    );
  }
}
