import 'package:flutter/material.dart';

import 'package:pythagon_admin/widgets/drawer_body.dart';
import 'package:pythagon_admin/widgets/profile_tile.dart';
import 'package:pythagon_admin/widgets/web_drawer.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currTab = 0;

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
