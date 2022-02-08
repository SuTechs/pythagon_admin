import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/screens/teacher_details_screen.dart';
import 'package:pythagon_admin/screens/work_details_screen.dart';
import 'package:pythagon_admin/screens/work_screen.dart';
import 'package:pythagon_admin/widgets/drawer_body.dart';
import 'package:pythagon_admin/widgets/profile_tile.dart';
import 'package:pythagon_admin/widgets/tab_widget.dart';
import 'package:pythagon_admin/widgets/web_drawer.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currTab = 2;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,


      drawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: DrawerBody(),
      ),

      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: WebDrawer(
                selectedIndex: currTab,
                onItemSelected: (index) => setState(() => currTab = index),
                items: navList,
              )),
          Expanded(
            flex: 4,
            child: Container(
              color: backgroundColor,
              child: Column(
                children: [
                  ProfileTile(),
                  Expanded(
                    flex: 4,
                     // child: TeacherDetailScreen(),
                     // child: WorkDetailScreen(),
                    child: Container(
                      color: backgroundColor,
                      child: pages[currTab],
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
