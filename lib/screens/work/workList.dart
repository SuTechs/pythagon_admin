import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/workDataTable.dart';

class WorkListScreen extends StatelessWidget {
  const WorkListScreen({Key? key}) : super(key: key);

  final _tabs = const <String>[
    'Pending',
    'Payment',
    'Float',
    'Assign',
    'Review',
    'Payment',
    'Close',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: CustomScaffold(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              indicator: BoxDecoration(
                color: const Color(0xfff3f2f7),
              ),
              isScrollable: true,
              unselectedLabelColor: Color(0xff70697B),
              labelColor: kActiveColor,
              tabs: [
                for (final tab in _tabs) Tab(text: tab),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            for (int i = 0; i < _tabs.length; i++) WorkDataTable(),
          ],
        ),
      ),
    );
  }
}
