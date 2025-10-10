import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/dashboard/bar_chart_vehicle_weight.dart';
import '../../../../main.dart';
import '../../../../utils/constants/text_style.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({super.key, required this.items});

  final BarChartVehicleWeight items;

  @override
  State<StatefulWidget> createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  final double width = 16.w;

  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    initWidget();
  }

  void initWidget() async {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setDataBar(); // เรียก setDataBar() ใน didChangeDependencies() แทน
  }

  void setDataBar() async {
    try {
      for (var i = 0; i < widget.items.labels!.length; i++) {
        showingBarGroups.add(makeGroupData(i, double.parse(widget.items.vechicleWeight![i].toString()), double.parse(widget.items.vechicleWeightOver![i].toString())));
      }
      // final barGroup1 = makeGroupData(0, 5, 12);
      // final barGroup2 = makeGroupData(1, 16, 12);
      // final barGroup3 = makeGroupData(2, 18, 5);
      // final barGroup4 = makeGroupData(3, 20, 16);
      // final barGroup5 = makeGroupData(4, 17, 6);
      // final barGroup6 = makeGroupData(5, 19, 1.5);
      // final barGroup7 = makeGroupData(6, 10, 1.5);
      // final _items = [
      //   barGroup1,
      //   barGroup2,
      //   barGroup3,
      //   barGroup4,
      //   barGroup5,
      //   barGroup6,
      //   barGroup7,
      // ];
      // showingBarGroups = _items;

      setState(() {});
    } catch (e) {
      logger.e('=setDataBar==errorr: $e');
    }
  }

  // หาค่าสูงสุดของแต่ละ BarChartRodData เพื่อกำหนด maxY
  double getMaxY(List<BarChartGroupData> barGroups) {
    double maxY = 0;
    for (var group in barGroups) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) {
          maxY = rod.toY;
        }
      }
    }
    return maxY;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
        aspectRatio: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 1.5.h : 1.8.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
          child: BarChart(
            BarChartData(
              maxY: getMaxY(showingBarGroups), // คำนวณ maxY จากข้อมูล
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
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
                  tooltipRoundedRadius: 12,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${rod.toY.toInt()} คัน',
                      AppTextStyle.title14bold(color: Theme.of(context).colorScheme.onSecondary),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
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
                    reservedSize: 20.h,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: showingBarGroups,
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      );
    });
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['26/07', '27/07', '28/07', '29/07', '30/07', '31/07', '01/08'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        widget.items.labels![value.toInt()],
        style: widget.items.labels!.length - 1 == value.toInt() ? AppTextStyle.label12bold() : AppTextStyle.label12normal(),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 2,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Theme.of(context).colorScheme.primary, // context พร้อมใช้ใน didChangeDependencies()
          width: width,
          borderRadius: BorderRadius.circular(2.r),
        ),
        BarChartRodData(
          toY: y2,
          color: Theme.of(context).colorScheme.error, // context พร้อมใช้ใน didChangeDependencies()
          width: width,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ],
    );
  }
}
