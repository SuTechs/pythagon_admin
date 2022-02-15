import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/widgets/CustomDataTable.dart';

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({Key? key}) : super(key: key);

  @override
  State<WorkListScreen> createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: _tabs.length, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// tabs

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: kForegroundColor,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Color(0xff70697B),
              labelColor: kActiveColor,
              tabs: [
                for (final tab in _tabs) Tab(text: tab),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),

          /// tab view
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                for (int i = 0; i < _tabs.length; i++) _DataList(),
              ],
            ),
          )
        ],
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
                CustomDataTable.getIdCell('6262'),

                /// Type
                CustomDataTable.getTypeCell(
                  kGreenActiveColor,
                  FontAwesome5.book_reader,
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Tammy Sanchez',
                  subtitle: 'Python',
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
