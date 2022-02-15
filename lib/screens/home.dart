import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../constants.dart';
import '../widgets/drawer_body.dart';
import '../widgets/profile_tile.dart';
import '../widgets/web_drawer.dart';
import 'admin/admin_screen.dart';
import 'analytics/analytics.dart';
import 'college/college_screen.dart';
import 'course/course_screen.dart';
import 'payment/payment_screen.dart';
import 'settings/settings_screen.dart';
import 'student/student_screen.dart';
import 'subject/subject_screen.dart';
import 'teacher/teacher_screen.dart';
import 'work/workList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<NavTabData> _navTabList = [
    NavTabData(
      icon: FeatherIcons.briefcase,
      title: 'Work',
    ),
    NavTabData(
      icon: FeatherIcons.home,
      title: 'Dashboard',
    ),
    NavTabData(
      icon: FeatherIcons.dollarSign,
      title: 'Payment',
    ),
    NavTabData(
      icon: FontAwesome5.chalkboard_teacher,
      title: 'Teachers ',
    ),
    NavTabData(
      icon: FontAwesome5.graduation_cap,
      title: 'Students',
    ),
    NavTabData(
      icon: FeatherIcons.book,
      title: 'Subjects',
    ),
    NavTabData(
      icon: Icons.lightbulb_outline_rounded,
      title: 'Course',
    ),
    NavTabData(
      icon: FontAwesome.bank,
      title: 'College ',
    ),
    NavTabData(
      icon: Icons.person,
      title: 'Admin',
    ),
    NavTabData(
      icon: FeatherIcons.settings,
      title: 'Settings',
    ),
  ];

  List<Widget> _pages = [
    WorkListScreen(),
    AnalyticsScreen(),
    PaymentScreen(),
    TeacherPageUtil(),
    StudentPageUtil(),
    SubjectScreen(),
    CourseScreen(),
    CollegeScreen(),
    AdminScreen(),
    SettingsScreen()
  ];

  int _currTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: kScaffoldKey,
      drawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: DrawerBody(),
      ),
      body: Row(
        children: [
          /// navigation tabs
          Expanded(
            flex: 1,
            child: WebDrawer(
              selectedIndex: _currTab,
              onTabChange: (index) => setState(() => _currTab = index),
              tabs: _navTabList,
            ),
          ),

          /// page
          Expanded(
            flex: 5,
            child: Container(
              color: kBackgroundColor,
              child: Column(
                children: [
                  /// profile tile
                  ProfileTile(),

                  /// page
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: kBackgroundColor,
                      child: Navigator(
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (_) => _pages[_currTab],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
