import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/work/workList.dart';

class TeacherDetailScreen extends StatefulWidget {
  const TeacherDetailScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TabController tabController2;
  String dropDownValue = "Filter";

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController2 = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    tabController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32.0,
                        ),
                        TeacherProfileTile(),
                        SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: kBackgroundColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          color: kForegroundColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TabBar(
                                indicatorColor: kActiveColor,
                                unselectedLabelColor: Color(0xff70697B),
                                labelColor: kActiveColor,
                                labelStyle: TextStyle(
                                    color: kTextDarkGrey,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    fontSize: 14.0),
                                tabs: const [
                                  Tab(
                                    text: "Docs Overview",
                                  ),
                                  Tab(
                                    text: "Documents",
                                  ),
                                ],
                                controller: tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 280,
                                child: TabBarView(
                                  controller: tabController,
                                  children: [DocsTabBody(), DocsTabBody()],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: kForegroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Color(0xff70697B),
                      labelColor: kActiveColor,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15.0),
                      tabs: const [
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "CSE",
                        ),
                        Tab(
                          text: "MECHANICAL",
                        ),
                        Tab(
                          text: "ELECTRICAL",
                        ),
                        Tab(
                          text: "BUSINESS",
                        ),
                        Tab(
                          text: "DATA SCIENCE",
                        ),
                      ],
                      controller: tabController2,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
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
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
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
          Container(
            height: 254.0,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBarView(
              controller: tabController2,
              children: [for (int i = 0; i < 6; i++) TeacherDetailsTable1()],
            ),
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
                          onPressed: () {},
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
              child: TeacherDetailsTable2())
        ],
      ),
    );
  }
}

class TeacherProfileTile extends StatelessWidget {
  const TeacherProfileTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 16.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
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
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outline_outlined,
                                  size: 18, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Username",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "uchit.chakma123",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_outlined,
                                  size: 18, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Phone",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "8979717380",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.email_outlined,
                                  size: 18, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Email",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "Sumit@gmail.Com",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(FontAwesome.bank,
                                  size: 16, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "College",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "Hkbk College Of Eng",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Iconic.book_open,
                                  size: 16, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Branch",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "Computer Science",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_sharp,
                                  size: 16, color: kTextColor2),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                "Joined",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor2,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            "24 Feb 2016",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kTextColor2,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                width: 130,
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
                    "Total",
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
                        color: kRedBgColor),
                    child: Center(
                      child: Icon(
                        Icons.star,
                        color: kRedActiveColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                  title: Text(
                    "4.5(5.0)",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor2,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    "Rating",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: kTextDarkGrey,
                        fontSize: 12),
                  ),
                ),
              ),
              Flexible(
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
                        FontAwesome5.check,
                        color: kGreenActiveColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                  title: Text(
                    "Verified",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor2,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    "Status",
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

class DocsTabBody extends StatelessWidget {
  const DocsTabBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Text(
              "Account No.",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "676587946545",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "Account Name",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "Uchit Chakma",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "IFSC Code",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "SBIN00212",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "PAN No",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "ESP00647",
              style: TextStyle(
                  color: kTextColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
              child: Divider(
                height: 0.6,
                color: kTextLightGrey.withOpacity(0.3),
              )),
          SizedBox(
            height: 8.0,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: kGreenBgColor,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(
                    color: kGreenActiveColor, fontWeight: FontWeight.w700),
              )),
            ),
          )
        ],
      ),
    );
  }
}

class TeacherDetailsTable1 extends StatelessWidget {
  TeacherDetailsTable1({Key? key}) : super(key: key);

  final List<TeacherDetailsTableData> dataList = [
    TeacherDetailsTableData(
        id: "#5h4ae",
        basicInfo: InfoData("PY", "PYTHON", ""),
        appliedDate: "28 Jan 2022",
        status: "Pending",
        rating: "4.5(90)",
        comment: "Pass but only for rookie"),
    TeacherDetailsTableData(
        id: "#9h3rf",
        basicInfo: InfoData("JV", "JAVA", ""),
        appliedDate: "28 Jan 2022",
        status: "Passed",
        rating: "1.5(44)",
        comment: "Excellent"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        dataRowHeight: 80.0,
        dividerThickness: 0.6,
        headingRowColor: MaterialStateProperty.all(kBackgroundColor),
        dataRowColor: MaterialStateProperty.all(kForegroundColor),
        columns: teacherDetailsHeaders1
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

                  //APPLIED DATE
                  DataCell(
                    Text(
                      teacher.appliedDate!,
                      maxLines: 1,
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
                              teacher.status!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, color: kActiveColor),
                            ),
                          ),
                        ),

                  //RATING
                  DataCell(
                    Text(
                      teacher.rating!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //COMMENT
                  DataCell(
                    Text(
                      teacher.comment!,
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
      ),
    );
  }
}

class TeacherDetailsTable2 extends StatelessWidget {
  TeacherDetailsTable2({Key? key}) : super(key: key);

  final List<TeacherDetailsTableData> dataList = [
    TeacherDetailsTableData(
      id: "#5h4ae",
      typeIcon: FontAwesome5.book_reader,
      basicInfo: InfoData("EN", "Need Essay For At", "English Grammar"),
      issueDate: "28 Jan 2022",
      dueDate: "28 Jan 2022",
      payment: r"$100",
      status: "Sent",
      rating: "4.5",
    ),
    TeacherDetailsTableData(
      id: "#5h4ae",
      typeIcon: Icons.access_time,
      basicInfo: InfoData("PY", "ML Project", "Python"),
      issueDate: "28 Jan 2022",
      dueDate: "28 Jan 2022",
      payment: r"$150",
      status: "Done",
      rating: "1.5",
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
        columns: teacherDetailsHeaders2
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

                  //TYPE
                  DataCell(
                    Container(
                      height: 44.0,
                      width: 44.0,
                      decoration: BoxDecoration(
                          color: kRedBgColor, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          teacher.typeIcon,
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

                  //ISSUED DATE
                  DataCell(
                    Text(
                      teacher.issueDate!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //DUE DATE
                  DataCell(
                    Text(
                      teacher.dueDate!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //PAYMENT
                  DataCell(
                    Text(
                      teacher.payment!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: kTextDarkGrey),
                    ),
                  ),

                  //STATUS
                  teacher.status == "Done"
                      ? DataCell(
                          Row(
                            children: [
                              Icon(
                                FontAwesome5.check_double,
                                color: kGreenActiveColor,
                                size: 18.0,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Done",
                                style: TextStyle(
                                    color: kTextColor2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        )
                      : DataCell(
                          Row(
                            children: [
                              Icon(
                                FontAwesome5.check,
                                color: kTextColor2,
                                size: 18.0,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                teacher.status!,
                                style: TextStyle(
                                    color: kTextColor2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        ),

                  //RATING
                  DataCell(
                    Text(
                      teacher.rating!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

class TeacherDetailsTableData {
  String id;
  InfoData basicInfo;
  String? appliedDate;
  String? status;
  String? rating;
  String? comment;

  IconData? typeIcon;
  String? issueDate;
  String? dueDate;
  String? payment;

  TeacherDetailsTableData(
      {required this.id,
      required this.basicInfo,
      this.appliedDate,
      this.status,
      this.rating,
      this.comment,
      this.typeIcon,
      this.issueDate,
      this.dueDate,
      this.payment});
}
