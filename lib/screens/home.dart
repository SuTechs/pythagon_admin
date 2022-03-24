import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pythagon_admin/screens/work/workList.dart';

import '../constants.dart';
import '../widgets/webDrawer.dart';
import 'admin/adminList.dart';
import 'analytics/analytics.dart';
import 'college/collegeList.dart';
import 'course/courseList.dart';
import 'payment/payment.dart';
import 'settings/settings.dart';
import 'student/studentList.dart';
import 'subject/subjectList.dart';
import 'teacher/teacherList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  late final List<_NavDrawerData> _drawerNavData = [
    /// Work
    _NavDrawerData(
      tabData: NavTabData(
        icon: FeatherIcons.briefcase,
        title: 'Work',
      ),
      screen: WorkListScreen(),
    ),

    /// Analytics
    _NavDrawerData(
      tabData: NavTabData(
        icon: FeatherIcons.barChart,
        title: 'Analytics',
      ),
      screen: AnalyticsScreen(),
    ),

    /// Payment
    _NavDrawerData(
      tabData: NavTabData(
        icon: FeatherIcons.dollarSign,
        title: 'Payment',
      ),
      screen: PaymentScreen(),
    ),

    /// Teachers
    _NavDrawerData(
      tabData: NavTabData(
        icon: FontAwesome5.chalkboard_teacher,
        title: 'Teachers ',
      ),
      screen: TeacherList(),
    ),

    /// Students
    _NavDrawerData(
      tabData: NavTabData(
        icon: FontAwesome.graduation_cap,
        title: 'Students',
      ),
      screen: StudentList(),
    ),

    /// Subjects
    _NavDrawerData(
      tabData: NavTabData(
        icon: FeatherIcons.book,
        title: 'Subjects',
      ),
      screen: SubjectList(),
    ),

    /// Course
    _NavDrawerData(
      tabData: NavTabData(
        icon: Icons.lightbulb_outline_rounded,
        title: 'Course',
      ),
      screen: CourseList(),
    ),

    /// College
    _NavDrawerData(
      tabData: NavTabData(
        icon: FontAwesome.bank,
        title: 'College ',
      ),
      screen: CollegeList(),
    ),

    /// Admin
    _NavDrawerData(
      tabData: NavTabData(
        icon: Icons.person,
        title: 'Admin',
      ),
      screen: AdminList(),
    ),

    /// Setting
    _NavDrawerData(
      tabData: NavTabData(
        icon: FeatherIcons.settings,
        title: 'Settings',
      ),
      screen: Settings(),
    ),
  ];

  int _currTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Row(
        children: [
          /// navigation tabs
          Expanded(
            flex: 1,
            child: WebDrawer(
              selectedIndex: _currTab,
              onTabChange: (index) {
                setState(() => _currTab = index);
                _navigatorKey.currentState?.maybePop();
              },
              tabs: _drawerNavData.map((e) => e.tabData).toList(),
            ),
          ),

          /// page
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (_) => _drawerNavData[_currTab].screen,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NavDrawerData {
  final NavTabData tabData;
  final Widget screen;

  _NavDrawerData({required this.tabData, required this.screen});
}
