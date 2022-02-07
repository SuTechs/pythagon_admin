import 'package:flutter/material.dart';
import 'package:pythagon_admin/screens/work_details_screen.dart';
import 'package:pythagon_admin/screens/work_screen.dart';
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
  int currTab = 0;

  Widget getBody() {
    return IndexedStack(
      index: currTab,
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Expanded(
                    flex: 1,
                    child: ProfileTile(),
                  ),
                  Expanded(
                    flex: 4,
                    child: WorkDetailScreen(),
                    // child: Container(
                    //   color: backgroundColor,
                    //   child: pages[currTab],
                    // ),
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
