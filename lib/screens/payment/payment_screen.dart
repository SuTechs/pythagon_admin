import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/screens/teacher/teacher_screen.dart';
import 'dart:math' as math;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String dropDownValue = "Last 28 days";
  String dropDownFilter = "Filter";

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: foregroundColor,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  FontAwesome.credit_card,
                                  size: 64,
                                  color: activeColor,
                                ),
                                title: Text(
                                  "Total Received",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: textColor2),
                                ),
                                subtitle: Text(
                                  r"$ 947,472.78",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      color: textColor2),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DropdownButton<String>(
                                      underline: SizedBox(),
                                      value: dropDownValue,
                                      // Change to variable
                                      isDense: true,
                                      items: <String>[
                                        'Last 28 days',
                                        'Last 3 months',
                                        'Last 6 months',
                                        'Last 1 year',
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
                                    ),
                                    SizedBox(
                                      height: 54.0,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 16.0, top: 8.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                decoration: BoxDecoration(
                                    color: greenBgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: ListTile(
                                    leading: Icon(
                                      FontAwesome5.chart_line,
                                      color: greenActiveColor,
                                      size: 64,
                                    ),
                                    title: Text(
                                      "Analytics",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: textDarkGrey),
                                    ),
                                    subtitle: Text(
                                      "10% since last month",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: textLightGrey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 16.0, top: 8.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                decoration: BoxDecoration(
                                    color: yellowBgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.timer,
                                    color: yellowActiveColor,
                                    size: 64,
                                  ),
                                  title: Text(
                                    "Pending",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: textDarkGrey),
                                  ),
                                  subtitle: Text(
                                    r"$ 500",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: textLightGrey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: foregroundColor,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  FontAwesome5.calculator,
                                  size: 64,
                                  color: Color(0xffFF3845),
                                ),
                                title: Text(
                                  "Total Expense",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: textColor2),
                                ),
                                subtitle: Text(
                                  r"$ 947,472.78",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      color: textColor2),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DropdownButton<String>(
                                      underline: SizedBox(),
                                      value: dropDownValue,
                                      // Change to variable
                                      isDense: true,
                                      items: <String>[
                                        'Last 28 days',
                                        'Last 3 months',
                                        'Last 6 months',
                                        'Last 1 year',
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
                                    ),
                                    SizedBox(
                                      height: 54.0,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 16.0, top: 8.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                decoration: BoxDecoration(
                                    color: greenBgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.graphic_eq,
                                      color: greenActiveColor,
                                      size: 64,
                                    ),
                                    title: Text(
                                      "Analytics",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: textDarkGrey),
                                    ),
                                    subtitle: Text(
                                      "10% since last month",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: textLightGrey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: 16.0, top: 8.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                decoration: BoxDecoration(
                                    color: yellowBgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.timer,
                                    color: yellowActiveColor,
                                    size: 64,
                                  ),
                                  title: Text(
                                    "Pending",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: textDarkGrey),
                                  ),
                                  subtitle: Text(
                                    r"$ 500",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: textLightGrey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: foregroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                            color: textColor2),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
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
                    ],
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
                        value: dropDownFilter, // Change to variable
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
                                  color: textDarkGrey),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropDownFilter = value!;
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
          // SizedBox(
          //   height: 32.0,
          // ),

          PaymentTable()
        ],
      ),
    );
  }
}

class PaymentTable extends StatelessWidget {
  PaymentTable({Key? key}) : super(key: key);

  final List<PaymentTableData> dataList = [
    PaymentTableData(
        "#5h4ae",
        "Failed",
        InfoData("DOWN", "Sumit Payment", "Failed"),
        "28 Jan 2022",
        r" $100",
        r"Uchit Paid $100"),
    PaymentTableData(
        "#7h4ae",
        "Pending",
        InfoData("UP", "Harshit Payment", "Pending"),
        "28 Jan 2022",
        r" $100",
        "Sumit closed"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DataTable(
        dataRowHeight: 80.0,
        dividerThickness: 0.6,
        headingRowColor: MaterialStateProperty.all(backgroundColor),
        dataRowColor: MaterialStateProperty.all(foregroundColor),
        columns: paymentHeaders
            .map((e) => DataColumn(
                    label: Container(
                  color: backgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
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
            .map((payment) => DataRow(cells: [
                  //ID
                  DataCell(
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Text(
                        payment.id,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: activeColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  //TYPE
                  DataCell(
                    payment.status == "Pending"
                        ? Container(
                            height: 44.0,
                            width: 44.0,
                            decoration: BoxDecoration(
                                color: yellowBgColor, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.access_time,
                                color: yellowActiveColor,
                                size: 20.0,
                              ),
                            ),
                          )
                        : Container(
                            height: 44.0,
                            width: 44.0,
                            decoration: BoxDecoration(
                                color: redBgColor, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                FontAwesome5.exclamation,
                                color: redActiveColor,
                                size: 20.0,
                              ),
                            ),
                          ),
                  ),

                  //PAYMENT INFO
                  DataCell(ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: (payment.paymentInfo.iconContent == "DOWN")
                        ? Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: redBgColor),
                            child: Center(
                              child: Transform.rotate(
                                  angle: 3 * math.pi / 4,
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: redActiveColor,
                                    size: 24.0,
                                  )),
                            ),
                          )
                        : Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: greenBgColor),
                            child: Center(
                              child: Transform.rotate(
                                  angle: -math.pi / 4,
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: greenActiveColor,
                                    size: 24.0,
                                  )),
                            ),
                          ),
                    title: Text(
                      payment.paymentInfo.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: textDarkGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      payment.paymentInfo.subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: textLightGrey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                  )),

                  // DATE
                  DataCell(
                    Text(
                      payment.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  ),

                  //AMOUNT
                  DataCell(
                    Text(
                      payment.amount,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: textDarkGrey),
                    ),
                  ),

                  //COMMENT
                  DataCell(
                    Text(
                      payment.comment,
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
    );
  }
}

class PaymentTableData {
  String id;
  String status;
  InfoData paymentInfo;
  String date;
  String amount;
  String comment;

  PaymentTableData(this.id, this.status, this.paymentInfo, this.date,
      this.amount, this.comment);
}
