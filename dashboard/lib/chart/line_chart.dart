import 'package:dashboard/chart_data/line_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LineChartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          border: Border.all(
            color: const Color(0xFFFF8000),
            width: 0.5,
          ),
        ),
        gridData: const FlGridData(
          drawHorizontalLine: false,
        ),
        titlesData: const FlTitlesData(
          //bottomTitles: _bottomTitles,
          /*leftTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),*/
        ),
        minX: 1,
        minY: 0,
        maxX: 7,
        maxY: 16,
        lineBarsData: lineChartBarData,
      ),);
}

}
