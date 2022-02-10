import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/bar_chart_widget.dart';
import '../../widgets/line_chart_widget.dart';
import '../../widgets/pie_chart_widet.dart';

class WorkListingScreen extends StatelessWidget {
  const WorkListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [




          SizedBox(
            height: 32.0,
          ),
          RevenueTile(),
          SizedBox(
            height: 32.0,
          ),
          AssignmentTile(),
          SizedBox(
            height: 32.0,
          ),
          UserTile(),
          SizedBox(
            height: 32.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Flexible(child: PieChartWidget()),
                SizedBox(
                  width: 32.0,
                ),
                Flexible(child: BarChartWidget()),
              ],
            ),
          ),

          SizedBox(
            width: 32.0,
          ),
        ],
      ),
    );
  }
}

class RevenueTile extends StatefulWidget {
  const RevenueTile({Key? key}) : super(key: key);

  @override
  State<RevenueTile> createState() => _RevenueTileState();
}

class _RevenueTileState extends State<RevenueTile> {
  String dropDownValue = "Last 28 days";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Revenue",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: textColor2, fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Commercial ",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textLightGrey,
                  fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IndicatorTile(
                        color: Color(0xff11D47B), title: "Total Revenue"),
                    IndicatorTile(color: Color(0xffFF3845), title: "Expense"),
                  ],
                ),
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
              ],
            ),
            SizedBox(
              height: 8,
            ),
            LineChartWidget(
              chartDataList: [
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xff11D47B)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.5),
                    FlSpot(2, 1),
                    FlSpot(4, 1.2),
                    FlSpot(5.5, 1.5),
                    FlSpot(7, 1.9),
                    FlSpot(9, 1),
                    FlSpot(10, 1.5),
                    FlSpot(11, 2.5),
                    FlSpot(12, 1.0),
                    FlSpot(13, 0.6),
                    FlSpot(14, 0.0),
                  ],
                ),
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xffFF3845)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.7),
                    FlSpot(2, 1.2),
                    FlSpot(4, 1.9),
                    FlSpot(5.5, 2.7),
                    FlSpot(7, 1.5),
                    FlSpot(9, 0.4),
                    FlSpot(10, 0.2),
                    FlSpot(11, 1.0),
                    FlSpot(12, 1.8),
                    FlSpot(13, 2.3),
                    FlSpot(14, 2.5),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AssignmentTile extends StatefulWidget {
  const AssignmentTile({Key? key}) : super(key: key);

  @override
  _AssignmentTileState createState() => _AssignmentTileState();
}

class _AssignmentTileState extends State<AssignmentTile> {
  String dropDownValue = "Last 28 days";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ASSIGNMENTS",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: textColor2, fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Commercial ",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textLightGrey,
                  fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IndicatorTile(color: Color(0xff9464F5), title: "Total"),
                    IndicatorTile(color: Color(0xffF9D643), title: "Students"),
                    IndicatorTile(color: Color(0xff9464F5), title: "Pending"),
                    IndicatorTile(color: Color(0xffF9D643), title: "Cancel"),
                    IndicatorTile(color: Color(0xff9464F5), title: "Progress"),
                  ],
                ),
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
              ],
            ),
            SizedBox(
              height: 8,
            ),
            LineChartWidget(
              chartDataList: [
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xffF9D643)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.5),
                    FlSpot(2, 1),
                    FlSpot(4, 1.2),
                    FlSpot(5.5, 1.5),
                    FlSpot(7, 1.9),
                    FlSpot(9, 1),
                    FlSpot(10, 1.5),
                    FlSpot(11, 2.5),
                    FlSpot(12, 1.0),
                    FlSpot(13, 0.6),
                    FlSpot(14, 0.0),
                  ],
                ),
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xff9464F5)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.7),
                    FlSpot(2, 1.2),
                    FlSpot(4, 1.9),
                    FlSpot(5.5, 2.7),
                    FlSpot(7, 1.5),
                    FlSpot(9, 0.4),
                    FlSpot(10, 0.2),
                    FlSpot(11, 1.0),
                    FlSpot(12, 1.8),
                    FlSpot(13, 2.3),
                    FlSpot(14, 2.5),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  const UserTile({Key? key}) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  String dropDownValue = "Last 10 days";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: foregroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: textColor2, fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Commercial ",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textLightGrey,
                  fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IndicatorTile(color: Color(0xff11D47B), title: "Teachers"),
                    IndicatorTile(color: Color(0xffFF3845), title: "Students"),
                  ],
                ),
                DropdownButton<String>(
                  underline: SizedBox(),
                  value: dropDownValue,
                  // Change to variable
                  isDense: true,
                  items: <String>[
                    'Last 10 days',
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
              ],
            ),
            SizedBox(
              height: 8,
            ),
            LineChartWidget(
              chartDataList: [
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xff11D47B)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.5),
                    FlSpot(2, 1),
                    FlSpot(4, 1.2),
                    FlSpot(5.5, 1.5),
                    FlSpot(7, 1.9),
                    FlSpot(9, 1),
                    FlSpot(10, 1.5),
                    FlSpot(11, 2.5),
                    FlSpot(12, 1.0),
                    FlSpot(13, 0.6),
                    FlSpot(14, 0.0),
                  ],
                ),
                LineChartBarData(
                  isCurved: true,
                  colors: [const Color(0xffFF3845)],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  spots: const [
                    //X,Y
                    FlSpot(0, 0.7),
                    FlSpot(2, 1.2),
                    FlSpot(4, 1.9),
                    FlSpot(5.5, 2.7),
                    FlSpot(7, 1.5),
                    FlSpot(9, 0.4),
                    FlSpot(10, 0.2),
                    FlSpot(11, 1.0),
                    FlSpot(12, 1.8),
                    FlSpot(13, 2.3),
                    FlSpot(14, 2.5),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IndicatorTile extends StatelessWidget {
  final Color color;
  final String title;

  const IndicatorTile({Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 16.0,
              width: 16.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: textColor2, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
