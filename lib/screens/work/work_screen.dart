import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/work/work_details_screen.dart';

class WorkPageUtil extends StatelessWidget {
  const WorkPageUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => WorkScreen()),
    );
  }
}

class WorkScreen extends StatefulWidget {
  const WorkScreen({Key? key}) : super(key: key);

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 32.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: foregroundColor,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Color(0xff70697B),
              labelColor: activeColor,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
              tabs: const [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Billing",
                ),
                Tab(
                  text: "Float",
                ),
                Tab(
                  text: "Assigned",
                ),
                Tab(
                  text: "Review",
                ),
                Tab(
                  text: "Payment",
                ),
                Tab(
                  text: "Close",
                ),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [for (int i = 0; i < 7; i++) WorkBody()],
            ),
          )
        ],
      ),
    );
  }
}

class WorkBody extends StatelessWidget {
  WorkBody({Key? key}) : super(key: key);

  final List<WorkTableData> dataList = [
    WorkTableData(
        "#5h4ae",
        FontAwesome5.book_reader,
        InfoData("EN", "Need Essay For At", "English Grammar"),
        "28 Jan 2022",
        "28 Jan 2022",
        "Ready To Float",
        r" $100",
        r"Uchit Paid $100"),
    WorkTableData(
        "#5h4ae",
        FontAwesome5.book_reader,
        InfoData("EN", "Need Essay For At", "English Grammar"),
        "28 Jan 2022",
        "28 Jan 2022",
        "Paid",
        r" $100",
        r"Uchit Paid $100"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTableEntity(
        dataList: dataList,
      ),
    );
  }
}

class DataTableEntity extends StatelessWidget {
  final List<WorkTableData> dataList;

  const DataTableEntity({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 80.0,
        dividerThickness: 0.6,
        headingRowColor: MaterialStateProperty.all(backgroundColor),
        dataRowColor: MaterialStateProperty.all(foregroundColor),
        columns: workDataHeaders
            .map((e) => DataColumn(
                    label: Container(
                  color: backgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: textDarkGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.0),
                  ),
                )))
            .toList(),
        rows: dataList
            .map((work) => DataRow(cells: [
                  //ID
                  DataCell(
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Text(
                        work.id,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: activeColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  //TYPE

                  DataCell(InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => WorkDetailScreen()));
                    },
                    child: Container(
                      height: 44.0,
                      width: 44.0,
                      decoration: BoxDecoration(
                          color: redBgColor, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          work.typeIcon,
                          color: redActiveColor,
                          size: 20.0,
                        ),
                      ),
                    ),
                  )),

                  //BASIC INFO
                  DataCell(ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: purpleBgColor),
                      child: Center(
                        child: Text(
                          work.basicInfo.iconContent,
                          style: TextStyle(
                              color: activeColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                      ),
                    ),
                    title: Text(
                      work.basicInfo.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: textDarkGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      work.basicInfo.subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: textLightGrey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                  )),

                  //ISSUE DATE
                  DataCell(
                    Text(
                      work.issueDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  ),

                  //DUE DATE
                  DataCell(
                    Text(
                      work.dueDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  ),

                  //BALANCE
                  DataCell(
                    Text(
                      work.balance,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  ),

                  //STATUS
                  work.status == "Paid"
                      ? DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: greenBgColor),
                            child: Text(
                              "Paid",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, color: greenActiveColor),
                            ),
                          ),
                        )
                      : DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: purpleBgColor),
                            child: Text(
                              work.status,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 14.0, color: activeColor),
                            ),
                          ),
                        ),

                  //COMMENT
                  DataCell(
                    Text(
                      work.comment,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  )
                ]))
            .toList(),
      ),
    );
  }
}

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
