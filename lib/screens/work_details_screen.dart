import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'dart:math' as math;

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
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
                                onTap: () {},
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
                                //ID
                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ), //ID
                                DataCell(
                                  Text(
                                    "#54ade",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.purple),
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
                                //ID
                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ), //ID
                                DataCell(
                                  Text(
                                    "#54ade",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.purple),
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
                                //ID
                                DataCell(
                                  Text(
                                    "□",
                                    style: TextStyle(
                                        fontSize: 16.0, color: textDarkGrey),
                                  ),
                                ), //ID
                                DataCell(
                                  Text(
                                    "#54ade",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.purple),
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
              ),
            )),
        Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      color: foregroundColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            indicatorColor:activeColor,
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
                                for (int i = 0; i < 3; i++) OverviewTabBody()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 400.0,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      color: foregroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "ACTIVITY",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: textDarkGrey),
                            ),




                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
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
              margin: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 24.0

              ),
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
            decoration: BoxDecoration(color: redBgColor),
            child: Center(
                child: Text(
              "Due",
              style: TextStyle(color: redActiveColor,fontWeight: FontWeight.w700),
            )),
          )
        ],
      ),
    );
  }
}
