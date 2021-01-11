import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/assignmentHome.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/utils/modal/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<bool>('bool');
  await Hive.openBox<String>('string');
  await Hive.openBox<double>('double');
  await Hive.openBox<int>('int');

  User().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => User(),
      builder: (context, _) {
        return MaterialApp(
          theme: Provider.of<User>(context).isDarkMode
              ? ThemeData.dark()
                  .copyWith(scaffoldBackgroundColor: kDarkModeBackgroundColor)
              : ThemeData.light()
                  .copyWith(scaffoldBackgroundColor: kLightModeBackgroundColor),
          debugShowCheckedModeBanner: false,
          title: 'Pythagon',
          home: AssignmentHome(),
        );
      },
    );
  }
}
