import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'dart:math' as math;

import '../widgets/activity_timeline.dart';

class TeacherDetailScreen extends StatefulWidget {
  const TeacherDetailScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String dropDownValue = "All";

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
                    SizedBox(
                      height: 32.0,
                    ),
                    Container(
                      color: foregroundColor,
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.pink),
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Uchit Chakma",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: textColor2,
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
                                                color: textLightGrey,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline_outlined,
                                                size: 18,
                                                color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "Username",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                              Icons.phone_outlined,
                                                size: 18,
                                                color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "Phone",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons.email_outlined,
                                                  size: 18,
                                                  color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "Email",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  FontAwesome.bank,
                                                  size: 16,
                                                  color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "College",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),   SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  Iconic.book_open,
                                                  size: 16,
                                                  color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "Branch",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_sharp,
                                                  size: 16,
                                                  color:textColor2
                                              ),
                                              SizedBox(width: 4.0,),
                                              Text(
                                                "Joined",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: textColor2,
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
                                                color: textColor2,
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
                                        color: textColor2,
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
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: redBgColor),
                                    child: Center(
                                      child: Icon(
                                        Icons.star,
                                        color: redActiveColor,
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
                                        color: textColor2,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Rating",
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
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: greenBgColor),
                                    child: Center(
                                      child: Icon(
                                        FontAwesome5.check,
                                        color: greenActiveColor,
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
                                        color: textColor2,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Status",
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
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: backgroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 32,
                    ),
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

class DocsTabBody extends StatelessWidget {
  const DocsTabBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Text(
              "Account No.",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "676587946545",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "Account Name",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "Uchit Chakma",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "IFSC Code",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "SBIN00212",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Text(
              "PAN No",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
            trailing: Text(
              "ESP00647",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
              child: Divider(
                height: 0.6,
                color: textLightGrey.withOpacity(0.3),
              )),
          SizedBox(
            height: 8.0,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: greenBgColor,
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(
                    color: greenActiveColor, fontWeight: FontWeight.w700),
              )),
            ),
          )
        ],
      ),
    );
  }
}
