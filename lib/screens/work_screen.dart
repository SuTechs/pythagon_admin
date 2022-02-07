import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';

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

  final List<String> idList = ["#5h4ae", "#8h2re"];
  final List<InfoData> infoList = [
    InfoData("EN", "Need Essay For At", "English Grammar"),
    InfoData("PY", "ML Project", "Python"),
  ];
  final List<IconData> typeList = [FontAwesome5.book_reader, Icons.access_time];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTableEntity(),

    );
  }
}


class DataTableEntity extends StatelessWidget {
  const DataTableEntity({Key? key}) : super(key: key);

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
        rows: [
          DataRow(cells: [
            //ID
            DataCell(
              Text(
                "#54ade",
                style: TextStyle(fontSize: 14.0, color: Colors.purple),
              ),
            ),

            //TYPE
            DataCell(
              Container(
                height: 44.0,
                width: 44.0,
                decoration:
                    BoxDecoration(color: redBgColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    FontAwesome5.book_reader,
                    color: redActiveColor,
                    size: 20.0,
                  ),
                ),
              ),
            ),

            //BASIC INFO
            DataCell(ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Container(
                width: 44.0,
                height: 44.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: purpleBgColor),
                child: Center(
                  child: Text(
                    "EN",
                    style: TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0),
                  ),
                ),
              ),
              title: Text(
                "Need Essay For At",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: textDarkGrey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                "English Grammar",
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
                "28 Jan 2022",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            ),

            //DUE DATE
            DataCell(
              Text(
                "28 Jan 2022",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            ),

            //BALANCE
            DataCell(
              Text(
                r"$100",
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            ),

            //STATUS
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: purpleBgColor),
                child: Text(
                  "Ready To Float",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: activeColor),
                ),
              ),
            ),

            //COMMENT
            DataCell(
              Text(
                r"Uchit Paid $100",
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            )
          ]),
          DataRow(cells: [
            //ID
            DataCell(
              Text(
                "#54ade",
                style: TextStyle(fontSize: 14.0, color: Colors.purple),
              ),
            ),

            //TYPE
            DataCell(
              Container(
                height: 44.0,
                width: 44.0,
                decoration:
                    BoxDecoration(color: redBgColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.access_time,
                    color: redActiveColor,
                    size: 20.0,
                  ),
                ),
              ),
            ),

            //BASIC INFO
            DataCell(ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Container(
                width: 44.0,
                height: 44.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: purpleBgColor),
                child: Center(
                  child: Text(
                    "PY",
                    style: TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0),
                  ),
                ),
              ),
              title: Text(
                "ML Project",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: textDarkGrey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                "Python",
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
                "28 Jan 2022",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            ),

            //DUE DATE
            DataCell(
              Text(
                "28 Jan 2022",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            ),

            //BALANCE
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: greenBgColor),
                child: Text(
                  "Paid",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: greenActiveColor),
                ),
              ),
            ),

            //STATUS
            DataCell(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: greenBgColor),
                child: Text(
                  "Closed",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: greenActiveColor),
                ),
              ),
            ),

            //COMMENT
            DataCell(
              Text(
                r"Uchit Paid $100",
                style: TextStyle(fontSize: 14.0, color: textDarkGrey),
              ),
            )
          ]),
        ],
      ),
    );
  }
}


class InfoData {
  late String iconContent;
  late String title;
  late String subtitle;

  InfoData(this.iconContent, this.title, this.subtitle);
}
