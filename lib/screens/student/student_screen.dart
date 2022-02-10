import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/student/student_details_screen.dart';
import 'dart:math' as math;

import '../work/work_screen.dart';


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
              headingRowColor: MaterialStateProperty.all(backgroundColor),
              dataRowColor: MaterialStateProperty.all(foregroundColor),
              columns: studentHeaders
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
                  .map((student) => DataRow(cells: [
                //ID
                DataCell(
                  InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Text(
                      student.id,
                      style: TextStyle(fontSize: 14.0, color: activeColor,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                        //BASIC INFO
                        DataCell(ListTile(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => StudentDetailScreen()));
                          },
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          leading: Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: purpleBgColor),
                            child: Center(
                              child: Text(
                                student.basicInfo.iconContent,
                                style: TextStyle(
                                    color: activeColor,
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
                                color: textDarkGrey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            student.basicInfo.subtitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: textLightGrey,
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
                            style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                          ),
                        ),

                        //TWORK
                        DataCell(
                          Text(
                            student.tWork,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                          ),
                        ),

                        //PWORK
                        DataCell(
                          Text(
                            student.pWork,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                          ),
                        ),

                        //PAYMENT
                        DataCell(
                          Text(
                            student.payment,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                          ),
                        ),

                        //DUE
                        DataCell(
                          Text(
                            student.due,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0, color: textDarkGrey),
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
