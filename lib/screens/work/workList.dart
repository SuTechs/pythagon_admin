import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/work/workDetails.dart';
import 'package:pythagon_admin/widgets/CustomDataTable.dart';
import 'package:pythagon_admin/widgets/customScaffold.dart';

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
            for (int i = 0; i < _tabs.length; i++) _DataList(),
          ],
        ),
      ),
    );
  }
}

class _DataList extends StatelessWidget {
  const _DataList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDataTable(
        headersLabel: const [
          "#",
          "TYPE",
          "BASIC INFO",
          "ISSUE DATE",
          "DUE DATE",
          "BALANCE",
          "STATUS",
          "COMMENT",
        ],
        dataRows: [
          for (int i = 0; i < 20; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => WorkDetails(),
                      ),
                    );
                  },
                ),

                /// Type
                CustomDataTable.getTypeCell(
                  kGreenActiveColor,
                  FontAwesome5.book_reader,
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Tammy Sanchez',
                  subtitle: 'Python',
                  noImageText: 'Py',
                ),

                /// Issue Date
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Due Date
                CustomDataTable.getTextCell('23 Apr 2022'),

                /// Balance
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell('Paid', const Color(0xff28c76f)),

                /// Comment
                CustomDataTable.getCommentCell(
                  'New Teacher Assigned For The Assignment',
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// old code will soon be gone

class WorkTableData {
  String id;
  IconData typeIcon;
  InfoData basicInfo;
  String issueDate;
  String dueDate;
  String status;
  String balance;
  String comment;

  WorkTableData(this.id, this.typeIcon, this.basicInfo, this.issueDate,
      this.dueDate, this.status, this.balance, this.comment);
}

class InfoData {
  late String iconContent;
  late String title;
  late String subtitle;

  InfoData(this.iconContent, this.title, this.subtitle);
}
