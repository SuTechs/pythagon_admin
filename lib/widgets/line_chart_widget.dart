import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class _LineChart extends StatelessWidget {
  final List<LineChartBarData> chartDataList;

  const _LineChart({required this.chartDataList});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1.copyWith(lineBarsData: chartDataList),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: [],
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        leftTitles: leftTitles(
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '200';
              case 2:
                return '400';
              case 3:
                return '600';
            }
            return '';
          },
        ),
      );

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 8,
        interval: 1,
        reservedSize: 40,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 20,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: (value) {
          return value.toString();
        },
      );

  FlGridData get gridData => FlGridData(
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
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.all(
          width: 0.5,
          color: const Color(0xff707070),
        ),
      );
}

class LineChartWidget extends StatelessWidget {
  final List<LineChartBarData> chartDataList;

  const LineChartWidget({Key? key, required this.chartDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
          color: foregroundColor,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 6.0),
            child: _LineChart(
              chartDataList: chartDataList,
            ),
          )),
    );
  }
}
