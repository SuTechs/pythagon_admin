import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';
import 'dart:math' as math;

import '../work/work_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AdminBody());
  }
}

class AdminBody extends StatelessWidget {
  AdminBody({Key? key}) : super(key: key);

  final List<AdminTableData> dataList = [
    AdminTableData(
      "#5h4ae",
      InfoData("UC", "Uchit Chakma", "Hi, this is uchit"),
      "28 Jan 2022",
      "Hello",
    ),
    AdminTableData(
      "#5h4ae",
      InfoData("UC", "Uchit Chakma", "Hi, this is uchit"),
      "28 Jan 2022",
      "Hello",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 32.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            // margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: foregroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                      color: textColor2),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        color: activeColor,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      "Add New",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DataTable(
            dataRowHeight: 80.0,
            dividerThickness: 0.6,
            headingRowColor: MaterialStateProperty.all(backgroundColor),
            dataRowColor: MaterialStateProperty.all(foregroundColor),
            columns: adminHeaders
                .map((e) => DataColumn(
                        label: Container(
                      color: backgroundColor,
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
                .map((ad) => DataRow(cells: [
                      //ID
                      DataCell(
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                          child: Text(
                            ad.id,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: activeColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      //INFO
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
                              ad.admin.iconContent,
                              style: TextStyle(
                                  color: activeColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        title: Text(
                          ad.admin.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: textDarkGrey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          ad.admin.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: textLightGrey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                      )),

                      //Date
                      DataCell(
                        Text(
                          ad.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                        ),
                      ),

                      //STATUS
                      DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: greenBgColor),
                          child: Text(
                            ad.status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, color: greenActiveColor),
                          ),
                        ),
                      ),

                      //ACTION
                      DataCell(Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: textDarkGrey,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Transform.rotate(
                            angle: math.pi / 2,
                            child: Icon(
                              Icons.more_horiz,
                              color: textDarkGrey,
                              size: 16.0,
                            ),
                          ),
                        ],
                      )),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class AdminTableData {
  String id;
  InfoData admin;
  String date;
  String status;

  AdminTableData(this.id, this.admin, this.date, this.status);
}
