import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/student/student_details_screen.dart';

import '../work/workList.dart';

class StudentPageUtil extends StatelessWidget {
  const StudentPageUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => StudentScreen()),
    );
  }
}

class StudentScreen extends StatelessWidget {
  StudentScreen({Key? key}) : super(key: key);

  final List<StudentTableData> dataList = [
    StudentTableData(
      "#5h4ae",
      InfoData("UC", "Uchit Chakma", "91+9876543210"),
      "28 Jan 2022",
      "800",
      "3",
      r"$800",
      r"$100",
    ),
    StudentTableData(
      "#5h4ae",
      InfoData("VS", "Vivkek Sharma", "+91 6957576890"),
      "28 Jan 2022",
      "800",
      "6",
      r"$800",
      r"$160",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              dataRowHeight: 80.0,
              dividerThickness: 0.6,
              headingRowColor: MaterialStateProperty.all(kBackgroundColor),
              dataRowColor: MaterialStateProperty.all(kForegroundColor),
              columns: studentHeaders
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
                  .map((student) => DataRow(cells: [
                        //ID
                        DataCell(
                          InkWell(
                            onTap: () {
                              kScaffoldKey.currentState!.openEndDrawer();
                            },
                            child: Text(
                              student.id,
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
                                    builder: (_) => StudentDetailScreen()));
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
                                student.basicInfo.iconContent,
                                style: TextStyle(
                                    color: kActiveColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                          title: Text(
                            student.basicInfo.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: kTextDarkGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            student.basicInfo.subtitle,
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
                            student.dateAdded,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                          ),
                        ),

                        //TWORK
                        DataCell(
                          Text(
                            student.tWork,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                          ),
                        ),

                        //PWORK
                        DataCell(
                          Text(
                            student.pWork,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                          ),
                        ),

                        //PAYMENT
                        DataCell(
                          Text(
                            student.payment,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                          ),
                        ),

                        //DUE
                        DataCell(
                          Text(
                            student.due,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
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
            ),
          ],
        ),
      ),
    );
  }
}

class StudentTableData {
  String id;
  InfoData basicInfo;
  String dateAdded;
  String tWork;
  String pWork;
  String payment;
  String due;

  StudentTableData(this.id, this.basicInfo, this.dateAdded, this.tWork,
      this.pWork, this.payment, this.due);
}
