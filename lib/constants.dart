import 'package:flutter/material.dart';

/// new constants

const Color kForegroundColor = Colors.white;
const Color kTextDarkGrey = Color(0xff6e6b7b);

/// old constants

final GlobalKey<ScaffoldState> kScaffoldKey = GlobalKey(); // Create a key

const Color kBackgroundColor = Color(0xffF3F3F3);
const Color kActiveColor = Color(0xff834DF3);
const Color kTextColor = Color(0xff645D6E);
const Color kPurpleBgColor = Color(0xffDAC7FF);
const Color kRedBgColor = Color(0xffFCCFCF);
const Color kRedActiveColor = Color(0xffEA5455);
const Color kGreenBgColor = Color(0xffE0F9EE);
const Color kGreenActiveColor = Color(0xff11D47B);
const Color kYellowBgColor = Color(0xffFFE5C6);
const Color kYellowActiveColor = Color(0xffFF9B26);

const List<Color> kActiveTabGradient = [
  Color(0xff834DF3),
  Color(0xff996CF5),
];
const Color kTextLightGrey = Color(0xffACA8B5);
const Color kTextColor2 = Color(0xff70697B);

const List<String> workDetailsDataHeaders = [
  "□",
  "#",
  "INFO",
  "RATING",
  "PRICE",
  "STATUS",
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
