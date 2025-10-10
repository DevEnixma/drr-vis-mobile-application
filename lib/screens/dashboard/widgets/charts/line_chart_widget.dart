import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/dashboard/reponse/dashboard_sum_plane_res.dart';
import '../../../../utils/constants/text_style.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    super.key,
    required this.items,
  });

  final List<DashboardSumPlaneRes> items;

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<String> labels = [];

  List<FlSpot> planceData = [];
  List<FlSpot> planceResultData = [];

  double maxY = 0;

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() {
    preDataChart(widget.items);
    maxY = calculateMaxY(widget.items); // กำหนดค่า maxY หลังจากเตรียมข้อมูล
  }

  void preDataChart(List<DashboardSumPlaneRes> items) {
    for (var i = 0; i < items.length; i++) {
      if (items[i].month != null && items[i].month != '' && items[i].month != 'null') {
        labels.add(items[i].month.toString());
      } else {
        labels.add(' ');
      }

      if (items[i].plan != null && items[i].plan != '' && items[i].plan != 'null') {
        planceData.add(FlSpot(double.parse(i.toString()), double.parse(items[i].plan.toString())));
      } else {
        planceData.add(FlSpot(double.parse(i.toString()), 0));
      }

      if (items[i].result != null && items[i].result != '' && items[i].result != 'null') {
        planceResultData.add(FlSpot(double.parse(i.toString()), double.parse(items[i].result.toString())));
      } else {
        planceResultData.add(FlSpot(double.parse(i.toString()), 0));
      }
    }
  }

  double calculateMaxY(List<DashboardSumPlaneRes> items) {
    double maxPlan = items.where((item) => item.plan != null && item.plan != '' && item.plan != 'null').map((item) => double.tryParse(item.plan.toString()) ?? 0).fold(0, (prev, next) => prev > next ? prev : next);

    double maxResult = items.where((item) => item.result != null && item.result != '' && item.result != 'null').map((item) => double.tryParse(item.result.toString()) ?? 0).fold(0, (prev, next) => prev > next ? prev : next);

    return (maxPlan > maxResult ? maxPlan : maxResult) * 1.1; // เพิ่ม 10% เพื่อเผื่อระยะห่างด้านบน
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
        aspectRatio: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 1.5.h : 1.8.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: planceData,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.error,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.error, Theme.of(context).colorScheme.surface.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: const FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: planceResultData,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.surface.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: const FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    interval: 1,
                    reservedSize: 20.h,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                verticalInterval: 1,
                drawHorizontalLine: false,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (group) {
                    if (group.x == 0) {
                      return Colors.white; // Color for the first bar
                    } else if (group.x == 1) {
                      return Colors.white; // Color for the second bar
                    } else {
                      return Colors.white; // Color for other bars
                    }
                  },
                  tooltipPadding: EdgeInsets.all(8.h),
                  tooltipRoundedRadius: 12.r,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.barIndex == 0 ? "แผน " : "ผล "}${spot.y.toInt()}',
                        AppTextStyle.title14bold(color: spot.barIndex == 0 ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: maxY,
            ),
          ),
        ),
      );
    });
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Text(
          labels[value.toInt()],
          style: labels.length - 1 == value.toInt() ? AppTextStyle.label12bold() : AppTextStyle.label12normal(),
        ),
      ),
    );
  }
}
