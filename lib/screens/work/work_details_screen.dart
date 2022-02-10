import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/work/work_listing_screen.dart';
import 'dart:math' as math;

import '../../widgets/activity_timeline.dart';

class WorkDetailScreen extends StatefulWidget {
  const WorkDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String dropDownValue = "All";

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
              flex: 5,
              child: Container(
                child: Column(

                  children: [
                    SizedBox(height: 32.0,),
                    Container(
                      color: foregroundColor,
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/logo.png",
                                    width: 144.0,
                                    height: 144.0,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "PYTHON",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: textDarkGrey,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "COMP SCIENCE",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: textDarkGrey,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "CREATE a audio detection model using machine learning",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff70697B),
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: textLightGrey,
                                            fontSize: 14),
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
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: purpleBgColor),
                                    child: Center(
                                      child: Icon(
                                        FeatherIcons.dollarSign,
                                        color: activeColor,
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
                                        color: textDarkGrey,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Total",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: textDarkGrey,
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
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: redBgColor),
                                    child: Center(
                                      child: Icon(
                                        Icons.calendar_today_sharp,
                                        color: redActiveColor,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "29 Jan 2021",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textDarkGrey,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Due Date",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: textDarkGrey,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  leading: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: redBgColor),
                                    child: Center(
                                      child: Icon(
                                        FontAwesome5.graduation_cap,
                                        color: redActiveColor,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "Uchit Chakma",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textDarkGrey,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "8979767368",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: textDarkGrey,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: foregroundColor,
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => WorkListingScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
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
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FeatherIcons.search,
                                        color: textDarkGrey,
                                      )),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  DropdownButton<String>(
                                    value: dropDownValue, // Change to variable
                                    isDense: true,
                                    items: <String>[
                                      'All',
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
                                              color: textDarkGrey),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValue = value!;
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: backgroundColor,
                          padding: EdgeInsets.all(16.0),
                          // margin: EdgeInsets.symmetric(horizontal: 16.0),
                          child: DataTable(
                            dataRowHeight: 80.0,
                            dividerThickness: 0.6,
                            headingRowColor:
                                MaterialStateProperty.all(backgroundColor),
                            dataRowColor:
                                MaterialStateProperty.all(foregroundColor),
                            columns: workDetailsDataHeaders
                                .map((e) => DataColumn(
                                        label: Container(
                                      color: backgroundColor,
                                      // padding: EdgeInsets.symmetric(vertical: 16.0),
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

                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ),

                                //ID
                                DataCell(
                                  InkWell(
                                    onTap: () {
                                      scaffoldKey.currentState!.openEndDrawer();
                                    },
                                    child: Text(
                                      "#74tae",
                                      style: TextStyle(fontSize: 14.0, color: activeColor,fontWeight: FontWeight.w600),
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
                                        shape: BoxShape.circle,
                                        color: purpleBgColor),
                                    child: Center(
                                      child: Text(
                                        "IMG",
                                        style: TextStyle(
                                            color: activeColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "Uchit Chakma",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textDarkGrey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "+91 8979636388",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textLightGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),

                                //RATING
                                DataCell(
                                  Text(
                                    "4.5(40)",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //PRICE
                                DataCell(
                                  Text(
                                    r"$100",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //STATUS
                                DataCell(Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: textDarkGrey,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Sent",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: textDarkGrey),
                                    ),
                                  ],
                                )),

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
                              ]),
                              DataRow(cells: [

                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ),
                                //ID
                                DataCell(
                                  InkWell(
                                    onTap: () {
                                      scaffoldKey.currentState!.openEndDrawer();
                                    },
                                    child: Text(
                                     "#54hde",
                                      style: TextStyle(fontSize: 14.0, color: activeColor,fontWeight: FontWeight.w600),
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
                                        shape: BoxShape.circle,
                                        color: purpleBgColor),
                                    child: Center(
                                      child: Text(
                                        "IMG",
                                        style: TextStyle(
                                            color: activeColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "Uchit Chakma",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textDarkGrey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "+91 8979636388",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textLightGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),

                                //RATING
                                DataCell(
                                  Text(
                                    "4.5(40)",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //PRICE
                                DataCell(
                                  Text(
                                    r"$100",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //STATUS
                                DataCell(Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: textDarkGrey,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Sent",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: textDarkGrey),
                                    ),
                                  ],
                                )),

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
                              ]),
                              DataRow(cells: [

                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ), //ID
                                //ID
                                DataCell(
                                  InkWell(
                                    onTap: () {
                                      scaffoldKey.currentState!.openEndDrawer();
                                    },
                                    child: Text(
                                      "#543he",
                                      style: TextStyle(fontSize: 14.0, color: activeColor,fontWeight: FontWeight.w600),
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
                                        shape: BoxShape.circle,
                                        color: purpleBgColor),
                                    child: Center(
                                      child: Text(
                                        "IMG",
                                        style: TextStyle(
                                            color: activeColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "Uchit Chakma",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textDarkGrey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    "+91 8979636388",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: textLightGrey,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),

                                //RATING
                                DataCell(
                                  Text(
                                    "4.5(40)",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //PRICE
                                DataCell(
                                  Text(
                                    r"$100",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, color: textDarkGrey),
                                  ),
                                ),

                                //STATUS
                                DataCell(Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: textDarkGrey,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Sent",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: textDarkGrey),
                                    ),
                                  ],
                                )),

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
                              ]),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 32.0,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      color: foregroundColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            indicatorColor: activeColor,
                            unselectedLabelColor: Color(0xff70697B),
                            labelColor: activeColor,
                            labelStyle: TextStyle(
                                color: textDarkGrey,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 14.0),
                            tabs: const [
                              Tab(
                                text: "Overview",
                              ),
                              Tab(
                                text: "Transaction",
                              ),
                              Tab(
                                text: "New",
                              ),
                            ],
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            height: 364.0,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                          OverviewTabBody(),
                                TransactionTabBody(),
                                NewTabBody()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Flexible(
                      child: Container(
                        // height: 400.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        color: foregroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ACTIVITY",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: textDarkGrey),
                              ),
                              Flexible(
                                  child: TimelineBuilder(
                                timeliners: [
                                  TimelineTile(
                                      msgType: 0,
                                      title: "Subjects changed",
                                      subtitle: "Subjects price changed",
                                      timeAgo: "3 days ago"),
                                  TimelineTile(
                                      msgType: 1,
                                      title: "Uchit Changes",
                                      subtitle:
                                          "Uploaded Files: I have uploaded the files of Vivek tutor. ",
                                      timeAgo: "2 hours ago"),
                                  TimelineTile(
                                      msgType: 1,
                                      title: "Harshit Ranjhan",
                                      subtitle:
                                          "@Uchitchakma: How many have you Changed. ",
                                      timeAgo: "2 hours ago"),
                                ],
                              )),
                              SizedBox(
                                height: 24.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8),
                                decoration: BoxDecoration(
                                    color: foregroundColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        width: 1, color: activeColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "New message",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: textDarkGrey),
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: activeColor,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 36.0,
                                    width: 36.0,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                        color: purpleBgColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Center(
                                      child: Icon(
                                        FeatherIcons.voicemail,
                                        color: activeColor,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 36.0,
                                    width: 36.0,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                        color: redBgColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Center(
                                      child: Icon(
                                        FeatherIcons.dollarSign,
                                        color: redActiveColor,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class TimelineBuilder extends StatelessWidget {
  final List<TimelineTile> timeliners;

  const TimelineBuilder({Key? key, required this.timeliners}) : super(key: key);

  //0=> Purple //1=>Yellow
  Widget getIndicator(int msgType) {
    if (msgType == 0) {
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
            border: Border.all(width: 3, color: purpleBgColor)),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: yellowActiveColor,
            border: Border.all(width: 3, color: yellowBgColor)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Timeline(
      indicatorSize: 20,
      children: timeliners
          .map(
            (e) => ListTile(
              title: Text(
                e.title,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textDarkGrey),
              ),
              subtitle: Text(
                e.subtitle,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: textLightGrey),
              ),
              trailing: Text(
                e.timeAgo,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: textLightGrey),
              ),
            ),
          )
          .toList(),
      indicators: timeliners.map((e) => getIndicator(e.msgType)).toList(),
    );
  }
}

class TimelineTile {
  TimelineTile({
    required this.msgType,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
  });

  final int msgType;
  final String title;
  final String subtitle;
  final String timeAgo;
}

class OverviewTabBody extends StatelessWidget {
  const OverviewTabBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Currency",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textColor2),
              ),
              Container(
                height: 24.0,
                width: 24.0,
                margin: EdgeInsets.symmetric(vertical: 24.0),
                decoration:
                    BoxDecoration(color: redBgColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    FeatherIcons.dollarSign,
                    color: redActiveColor,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),
          Text(
            "DETAILS",
            style: TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.w600, color: textColor2),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DEAL AMOUNT",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textDarkGrey),
              ),
              Text(
                r"$500",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textColor2),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "COUPOUN",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textDarkGrey),
              ),
              Text(
                "FREE",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textColor2),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TAX",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textDarkGrey),
              ),
              Text(
                r"$50",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textColor2),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textDarkGrey),
              ),
              Text(
                r"$550",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: textColor2),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(color: redBgColor,borderRadius: BorderRadius.circular(4.0)),
            child: Center(
                child: Text(
              "Due",
              style:
                  TextStyle(color: redActiveColor, fontWeight: FontWeight.w700),
            )),
          )
        ],
      ),
    );
  }
}

class TransactionTabBody extends StatelessWidget {
  const TransactionTabBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "ALL TRANSACTION",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),

          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0,top: 24.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),

          SizedBox(
            height: 16,
          ),

          ListTile(
            leading: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: redBgColor
              ),
              child: Center(
                child: Transform.rotate(
                    angle: 3*math.pi/4,
                    child: Icon(Icons.arrow_back_outlined,color: redActiveColor,size: 24.0,)),
              ),
            ),
            title:     Text(
              "Money Debited",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: textColor2),
            ),
            subtitle:    Text(
              "28 Jan 2022",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: textColor2),
            ) ,

            trailing:  Text(
              r"-$50",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: redActiveColor),
            )

          ),    ListTile(
            leading: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greenBgColor
              ),
              child: Center(
                child: Transform.rotate(
                    angle: -math.pi/4,
                    child: Icon(Icons.arrow_back_outlined,color: greenActiveColor,size: 24.0,)),
              ),
            ),
            title:     Text(
              "Money Credited",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: textColor2),
            ),
            subtitle:    Text(
              "28 Jan 2022",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: textColor2),
            ) ,

            trailing:  Text(
              r"+$50",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: greenActiveColor),
            )

          ),


        ],
      ),
    );
  }
}

class NewTabBody extends StatelessWidget {
  const NewTabBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "PAYMENT",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),

          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0,top: 24.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),

          SizedBox(
            height: 16,
          ),

          Text(
            "CREDIT/DEBIT",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),
          SizedBox(
            height: 8,
          ),

          Text(
            r"$100",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),
          SizedBox(
            height: 8,
          ),

          Text(
            "This Is advance comment",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0,top: 24.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),
          SizedBox(
            height: 16,
          ),
          Text(
            "Attachment",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor2),
          ),
          ListTile(
            leading: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
            ),
            title: Text(
              "Screenshot82313.jpg",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            trailing: Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 12.0,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.0,),
          InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(color: greenActiveColor,borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )),
            ),
          )


        ],
      ),
    );
  }
}


