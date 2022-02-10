import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pythagon_admin/screens/admin/admin_screen.dart';
import 'package:pythagon_admin/screens/college/college_screen.dart';
import 'package:pythagon_admin/screens/course/course_screen.dart';
import 'package:pythagon_admin/screens/payment/payment_screen.dart';
import 'package:pythagon_admin/screens/settings/settings_screen.dart';
import 'package:pythagon_admin/screens/student/student_screen.dart';
import 'package:pythagon_admin/screens/subject/subject_screen.dart';
import 'package:pythagon_admin/screens/teacher/teacher_screen.dart';
import 'package:pythagon_admin/screens/work/work_screen.dart';
import 'package:pythagon_admin/widgets/web_drawer.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

const Color foregroundColor = Colors.white;
const Color backgroundColor = Color(0xffF3F3F3);
const Color activeColor = Color(0xff834DF3);
const Color textColor = Color(0xff645D6E);
const Color purpleBgColor = Color(0xffDAC7FF);
const Color redBgColor = Color(0xffFCCFCF);
const Color redActiveColor = Color(0xffEA5455);
const Color greenBgColor = Color(0xffE0F9EE);
const Color greenActiveColor = Color(0xff11D47B);
const Color yellowBgColor = Color(0xffFFE5C6);
const Color yellowActiveColor = Color(0xffFF9B26);

const List<Color> activeTabGradient = [
  Color(0xff834DF3),
  Color(0xff996CF5),
];
const Color textDarkGrey = Color(0xff4B4B4B);
const Color textLightGrey = Color(0xffACA8B5);
const Color textColor2 = Color(0xff70697B);

const List<String> workDataHeaders = [
  "#",
  "TYPE",
  "BASIC INFO",
  "ISSUE DATE",
  "DUE DATE",
  "BALANCE",
  "STATUS",
  "COMMENT",
];

const List<String> workDetailsDataHeaders = [
  "□",
  "#",
  "INFO",
  "RATING",
  "PRICE",
  "STATUS",
  "ACTION",
];

const List<String> teacherHeaders = [
  "#",
  "BASIC INFO",
  "DATE",
  "RATING",
  "PAYMENT",
  "DUE",
  "STATUS",
  "SUBJECT",
  "ACTION",
];

const List<String> teacherDetailsHeaders1 = [
  "#",
  "BASIC INFO",
  "APPLIED DATE",
  "STATUS",
  "RATING",
  "COMMENT",
  "ACTION",
];

const List<String> teacherDetailsHeaders2 = [
  "ID",
  "TYPE",
  "BASIC INFO",
  "ISSUE DATE",
  "DUE DATE",
  "PAYMENT",
  "STATUS",
  "RATING",
  "ACTION",
];

const List<String> studentHeaders = [
  "#",
  "BASIC INFO",
  "DATE ADDED",
  "TWORK",
  "PWORK",
  "PAYMENT",
  "DUE",
  "ACTION"
];

const List<String> studentListHeaders = [
  "#",
  "BASIC INFO",
  "DATE",
  "IS ACTIVE",
  "UPDATED ON",
  "VISIBILITY",
  "ACTION"
];

const List<String> studentDetailsHeaders = [
  "#",
  "TYPE",
  "BASIC INFO",
  "ISSUED",
  "DUE DATE",
  "BALANCE",
  "STATUS",
  "COMMENT",
];

const List<String> courseListingHeaders = [
  "□",
  "#",
  "COURSES",
  "SUBJECTS",
  "DATE",
  "ISACTIVE",
  "UPDATED ON",
  "ACTION",
];

const List<String> collegeListingHeaders = [
  "□",
  "#",
  "COLLEGE",
  "ADDRESS",
  "DATE",
  "ACTION",
];

const List<String> adminHeaders = [
  "#",
  "ADMIN INFO",
  "DATE",
  "STATUS",
  "ACTION",
];

const List<String> subjectsHeaders = [
  "#",
  "BASIC INFO",
  "DATE",
  "IS ACTIVE",
  "UPDATED ON",
  "VISIBILITY",
  "ACTION",
];
const List<String> paymentHeaders = [
  "#",
  "STATUS",
  "PAYMENT INFO",
  "DATE",
  "AMOUNT",
  "COMMENT",
  "ACTION",
];

List<Widget> pages = [
  WorkPageUtil(),
  PaymentScreen(),
  TeacherPageUtil(),
  StudentPageUtil(),
  SubjectScreen(),
  CourseScreen(),
  CollegeScreen(),
  AdminScreen(),
  SettingsScreen()
];

final List<NavTabData> navList = [
  NavTabData(
    icon: FeatherIcons.briefcase,
    title: 'Work',
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
