import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/student/student_list_screen.dart';
import 'package:pythagon_admin/screens/work/workList.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  String dropDownValue = "Filter";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 32.0,
          ),
          StudentDetailsProfileTile(),
          SizedBox(
            height: 24.0,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: kForegroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Work",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: kTextColor2),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => StudentListScreen()));
                          },
                          icon: Icon(
                            FeatherIcons.search,
                            color: kTextDarkGrey,
                          )),
                      SizedBox(
                        width: 8.0,
                      ),
                      DropdownButton<String>(
                        value: dropDownValue, // Change to variable
                        isDense: true,
                        items: <String>[
                          'Filter',
                          'Something',
                          'Anything',
                          'Nothing'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: kTextDarkGrey),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: StudentDetailsTable())
        ],
      ),
    );
  }
}

class StudentDetailsTable extends StatelessWidget {
  StudentDetailsTable({Key? key}) : super(key: key);

  final List<StudentDetailsTableData> dataList = [
    StudentDetailsTableData(
      "#5h4ae",
      FontAwesome5.book_reader,
      InfoData("EN", "Need Essay For At", "English Grammar"),
      "28 Jan 2022",
      "28 Jan 2022",
      r"$100",
      "Ready To Float",
      r"Uchit Paid $100",
    ),
    StudentDetailsTableData(
      "#7h4td",
      Icons.access_time,
      InfoData("PY", "ML Project", "Python"),
      "28 Jan 2022",
      "28 Jan 2022",
      "Paid",
      "Closed",
      "Sumit closed",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        dataRowHeight: 80.0,
        dividerThickness: 0.6,
        headingRowColor: MaterialStateProperty.all(kBackgroundColor),
        dataRowColor: MaterialStateProperty.all(kForegroundColor),
        columns: studentDetailsHeaders
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

                  //TYPE
                  DataCell(
                    Container(
                      height: 44.0,
                      width: 44.0,
                      decoration: BoxDecoration(
                          color: kRedBgColor, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          student.typeIcon,
                          color: kRedActiveColor,
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

                  //ISSUED DATE
                  DataCell(
                    Text(
                      student.issuedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //DUE DATE
                  DataCell(
                    Text(
                      student.dueDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //PAYMENT
                  student.balance == "Paid"
                      ? DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: kGreenBgColor),
                            child: Text(
                              "Paid",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, color: kGreenActiveColor),
                            ),
                          ),
                        )
                      : DataCell(
                          Text(
                            student.balance,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                          ),
                        ),

                  //STATUS
                  student.status == "Closed"
                      ? DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: kGreenBgColor),
                            child: Text(
                              "Closed",
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
                              student.status,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, color: kActiveColor),
                            ),
                          ),
                        ),

                  //COMMENT
                  DataCell(
                    Text(
                      student.comment,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),
                ]))
            .toList(),
      ),
    );
  }
}

class StudentDetailsProfileTile extends StatelessWidget {
  StudentDetailsProfileTile({Key? key}) : super(key: key);

  final List<StudentProfileAttr> profileAttr = [
    StudentProfileAttr(
        "Username", Icons.person_outline_outlined, "uchit.chakma123"),
    StudentProfileAttr("Phone", Icons.phone_outlined, "9876543210"),
    StudentProfileAttr("Email", Icons.email_outlined, "uchit@gmail.com"),
    StudentProfileAttr(
        "College", FontAwesome.bank, "Hbk College of Engineering"),
    StudentProfileAttr(
        "Username", Icons.person_outline_outlined, "uchit.chakma123"),
    StudentProfileAttr("Phone", Icons.phone_outlined, "9876543210"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.pink),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Uchit Chakma",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kTextColor2,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Here goes the description about the description of the description to be described ",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextLightGrey,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    childAspectRatio: 8,
                    // physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,

                    children: List.generate(profileAttr.length, (index) {
                      return Row(
                        children: [
                          Row(
                            children: [
                              Icon(profileAttr[index].iconData,
                                  size: 18, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                profileAttr[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            profileAttr[index].value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      );
                    }),
                  ),
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(Icons.person_outline_outlined,
                  //                 size: 18, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "Username",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "uchit.chakma123",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 16,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(Icons.phone_outlined,
                  //                 size: 18, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "Phone",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "8979717380",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 16,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(Icons.email_outlined,
                  //                 size: 18, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "Email",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "Sumit@gmail.Com",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 16,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(FontAwesome.bank,
                  //                 size: 16, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "College",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "Hkbk College Of Eng",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 16,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(Iconic.book_open,
                  //                 size: 16, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "Branch",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "Computer Science",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 16,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(Icons.calendar_today_sharp,
                  //                 size: 16, color: textColor2),
                  //             SizedBox(
                  //               width: 4.0,
                  //             ),
                  //             Text(
                  //               "Joined",
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: textColor2,
                  //                   fontSize: 14),
                  //             ),
                  //           ],
                  //         ),
                  //         Text(
                  //           "24 Feb 2016",
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               color: textColor2,
                  //               fontSize: 14),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 60,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: kPurpleBgColor),
                    child: Center(
                      child: Icon(
                        FeatherIcons.dollarSign,
                        color: kActiveColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                  title: Text(
                    r"$300",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor2,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    r"Total- $5000",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: kTextDarkGrey,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 60,
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: kGreenBgColor),
                    child: Center(
                      child: Icon(
                        Icons.work_outline_rounded,
                        color: kGreenActiveColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                  title: Text(
                    "4",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor2,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    "50",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: kTextDarkGrey,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class StudentDetailsTableData {
  String id;
  IconData typeIcon;
  InfoData basicInfo;
  String issuedDate;
  String dueDate;
  String balance;
  String status;
  String comment;

  StudentDetailsTableData(this.id, this.typeIcon, this.basicInfo,
      this.issuedDate, this.dueDate, this.balance, this.status, this.comment);
}

class StudentProfileAttr {
  String title;
  IconData iconData;
  String value;

  StudentProfileAttr(this.title, this.iconData, this.value);
}
