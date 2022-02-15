import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pythagon_admin/constants.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 16,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 10,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 13,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 13,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 14,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 10,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 5,
              colors: [Color(0xff00E2CA)])
        ],
      ),
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(
              width: 16.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              y: 13,
              colors: [Color(0xff00E2CA)])
        ],
      ),
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: kForegroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Latest Statistics",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor2,
                        fontSize: 20),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: kTextColor2,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "2019-05-01 to 2019-05-01",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kTextColor2,
                            fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    // barTouchData: BarTouchData(
                    //     touchTooltipData: BarTouchTooltipData(
                    //       tooltipBgColor: Colors.grey,
                    //       getTooltipItem: (_a, _b, _c, _d) => null,
                    //     ),
                    //     touchCallback: (FlTouchEvent event, response) {
                    //       if (response == null || response.spot == null) {
                    //         setState(() {
                    //           touchedGroupIndex = -1;
                    //           showingBarGroups = List.of(rawBarGroups);
                    //         });
                    //         return;
                    //       }
                    //
                    //       touchedGroupIndex =
                    //           response.spot!.touchedBarGroupIndex;
                    //
                    //       setState(() {
                    //         if (!event.isInterestedForInteractions) {
                    //           touchedGroupIndex = -1;
                    //           showingBarGroups = List.of(rawBarGroups);
                    //           return;
                    //         }
                    //         showingBarGroups = List.of(rawBarGroups);
                    //         if (touchedGroupIndex != -1) {
                    //           var sum = 0.0;
                    //           for (var rod
                    //               in showingBarGroups[touchedGroupIndex]
                    //                   .barRods) {
                    //             sum += rod.y;
                    //           }
                    //           final avg = sum /
                    //               showingBarGroups[touchedGroupIndex]
                    //                   .barRods
                    //                   .length;
                    //
                    //           showingBarGroups[touchedGroupIndex] =
                    //               showingBarGroups[touchedGroupIndex].copyWith(
                    //             barRods: showingBarGroups[touchedGroupIndex]
                    //                 .barRods
                    //                 .map((rod) {
                    //               return rod.copyWith(y: avg);
                    //             }).toList(),
                    //           );
                    //         }
                    //       });
                    //     }),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          return "${value.toInt() + 7}/12";
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 16,
                        reservedSize: 44,
                        interval: 4,
                        getTitles: (value) {
                          return "${value * 100}";
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xff707070),
                      ),
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      verticalInterval: 2,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff707070),
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xff707070),
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
