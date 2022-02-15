import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';

import '../work/workList.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CourseBody());
  }
}

class CourseBody extends StatelessWidget {
  CourseBody({Key? key}) : super(key: key);

  final List<CourseTableData> dataList = [
    CourseTableData(
      "#5h4ae",
      InfoData("EN", "Computer", ""),
      "PY,C++,JAVA",
      "28 Jan 2022",
      "Both",
      "28 Jan 2022",
    ),
    CourseTableData(
      "#5h4ae",
      InfoData("PY", "Python", ""),
      "SQL,PHP,MTH",
      "28 Jan 2022",
      "Student",
      "28 Jan 2022",
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
            color: kForegroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Courses",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                      color: kTextColor2),
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
                        color: kActiveColor,
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
            headingRowColor: MaterialStateProperty.all(kBackgroundColor),
            dataRowColor: MaterialStateProperty.all(kForegroundColor),
            columns: courseListingHeaders
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
                      //□
                      DataCell(
                        Text(
                          "□",
                          style:
                              TextStyle(fontSize: 16.0, color: kTextDarkGrey),
                        ),
                      ),
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

                      //COURSE
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
                              student.course.iconContent,
                              style: TextStyle(
                                  color: kActiveColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        title: Text(
                          student.course.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: kTextDarkGrey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          student.course.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: kTextLightGrey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                      )),

                      //SUBJECTS
                      DataCell(
                        Text(
                          student.subjects,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                        ),
                      ),

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
    );
  }
}

class CourseTableData {
  String id;
  InfoData course;
  String subjects;
  String date;
  String isActive;
  String updatedOn;

  CourseTableData(this.id, this.course, this.subjects, this.date, this.isActive,
      this.updatedOn);
}
