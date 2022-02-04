import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pythagon_admin/screens/work_screen.dart';
import 'package:pythagon_admin/widgets/web_drawer.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';


const Color foregroundColor = Colors.white;
const Color backgroundColor = Color(0xffF3F3F3);
const Color activeColor = Color(0xff834DF3);
const Color textColor = Color(0xff645D6E);
const List<Color> activeTabGradient = [
  Color(0xff834DF3),
  Color(0xff996CF5),
];
const Color textDarkGrey = Color(0xff4B4B4B);
const Color textLightGrey = Color(0xffACA8B5);

List<Widget> pages = [
  WorkScreen(),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Payment",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Teachers",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Students",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Subjects",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Course",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "College",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Admin",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
  Container(
    color: backgroundColor,
    alignment: Alignment.center,
    child: Text(
      "Settings",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ),
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
