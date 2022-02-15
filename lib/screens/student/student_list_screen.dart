import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';

import '../work/workList.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StudentListBody());
  }
}

class StudentListBody extends StatelessWidget {
  StudentListBody({Key? key}) : super(key: key);

  final List<StudentListTableData> dataList = [
    StudentListTableData(
      "#5h4ae",
      InfoData("EN", "Grammar", ""),
      "28 Jan 2022",
      "Both",
      "28 Jan 2022",
      "Both",
    ),
    StudentListTableData(
      "#7h4ay",
      InfoData("PY", "Python", ""),
      "28 Jan 2022",
      "Student",
      "28 Jan 2022",
      "Student",
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
          DataTable(
            dataRowHeight: 80.0,
            dividerThickness: 0.6,
            headingRowColor: MaterialStateProperty.all(kBackgroundColor),
            dataRowColor: MaterialStateProperty.all(kForegroundColor),
            columns: studentListHeaders
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
                          student.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                        ),
                      ),

                      //IS  ACTIVE
                      DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: kGreenBgColor),
                          child: Text(
                            student.isActive,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, color: kGreenActiveColor),
                          ),
                        ),
                      ),

                      //UPDATED ON
                      DataCell(
                        Text(
                          student.updatedOn,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                        ),
                      ),
                      //VISIBILITY
                      DataCell(
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: kGreenBgColor),
                          child: Text(
                            student.visibility,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, color: kGreenActiveColor),
                          ),
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
    );
  }
}

class StudentListTableData {
  String id;
  InfoData basicInfo;
  String date;
  String isActive;
  String updatedOn;
  String visibility;

  StudentListTableData(this.id, this.basicInfo, this.date, this.isActive,
      this.updatedOn, this.visibility);
}