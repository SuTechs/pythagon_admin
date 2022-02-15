import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/teacher/teacher_details_screen.dart';

class TeacherPageUtil extends StatelessWidget {
  const TeacherPageUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => TeacherScreen()),
    );
  }
}

class TeacherScreen extends StatelessWidget {
  TeacherScreen({Key? key}) : super(key: key);

  final List<TeacherTableData> dataList = [
    TeacherTableData(
      "#5h4ae",
      InfoData("UC", "Uchit Chakma", "91+9876543210"),
      "4.5(90)",
      "4.5(90)",
      r"$800",
      r"$100",
      "Pending",
      "PY,C++,C....",
    ),
    TeacherTableData(
      "#9h1ae",
      InfoData("VS", "Vivek Sharma", "91+6957576890"),
      "4.5(90)",
      "4.5(90)",
      r"$800",
      r"$160",
      "Passed",
      "PY,C++,C....",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTableEntity(
              dataList: dataList,
            )
          ],
        ));
  }
}

class DataTableEntity extends StatelessWidget {
  final List<TeacherTableData> dataList;

  const DataTableEntity({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowHeight: 80.0,
      dividerThickness: 0.6,
      headingRowColor: MaterialStateProperty.all(kBackgroundColor),
      dataRowColor: MaterialStateProperty.all(kForegroundColor),
      columns: teacherHeaders
          .map((e) => DataColumn(
                  label: Container(
                color: kBackgroundColor,
                child: Text(
                  e,
                  style: TextStyle(
                      color: kTextDarkGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0),
                ),
              )))
          .toList(),
      rows: dataList
          .map((teacher) => DataRow(cells: [
                //ID
                DataCell(
                  InkWell(
                    onTap: () {
                      kScaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Text(
                      teacher.id,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: kActiveColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                //BASIC INFO
                DataCell(ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TeacherDetailScreen()));
                  },
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kPurpleBgColor),
                    child: Center(
                      child: Text(
                        teacher.basicInfo.iconContent,
                        style: TextStyle(
                            color: kActiveColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 14.0),
                      ),
                    ),
                  ),
                  title: Text(
                    teacher.basicInfo.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: kTextDarkGrey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    teacher.basicInfo.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: kTextLightGrey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                )),

                //DATE
                DataCell(
                  Text(
                    teacher.date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                  ),
                ),

                //RATING
                DataCell(
                  Text(
                    teacher.rating,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                  ),
                ),

                //PAYMENT
                DataCell(
                  Text(
                    teacher.payment,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                  ),
                ),

                //DUE
                DataCell(
                  Text(
                    teacher.due,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                  ),
                ),

                //STATUS
                teacher.status == "Passed"
                    ? DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: kGreenBgColor),
                          child: Text(
                            "Passed",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, color: kGreenActiveColor),
                          ),
                        ),
                      )
                    : DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: kPurpleBgColor),
                          child: Text(
                            teacher.status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kActiveColor),
                          ),
                        ),
                      ),

                //COMMENT
                DataCell(
                  Text(
                    teacher.subject,
                    style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                  ),
                ),

                //ACTION
                DataCell(Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: kTextDarkGrey,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Transform.rotate(
                      angle: math.pi / 2,
                      child: Icon(
                        Icons.more_horiz,
                        color: kTextDarkGrey,
                        size: 16.0,
                      ),
                    ),
                  ],
                )),
              ]))
          .toList(),
    );
  }
}

class TeacherTableData {
  String id;
  InfoData basicInfo;
  String date;
  String rating;
  String payment;
  String due;
  String status;
  String subject;

  TeacherTableData(this.id, this.basicInfo, this.date, this.rating,
      this.payment, this.due, this.status, this.subject);
}

class InfoData {
  late String iconContent;
  late String title;
  late String subtitle;

  InfoData(this.iconContent, this.title, this.subtitle);
}
