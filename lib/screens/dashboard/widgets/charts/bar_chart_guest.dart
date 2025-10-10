import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';

class BarChartGuest extends StatefulWidget {
  const BarChartGuest({super.key});

  @override
  State<BarChartGuest> createState() => _BarChartGuestState();
}

class _BarChartGuestState extends State<BarChartGuest> {
  @override
  void initState() {
    super.initState();
  }

  int? touchedGroupIndex;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
        aspectRatio: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 1.3.h : 1.8.h,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.dashboardVehicleWeightInspectionStatus == DashboardVehicleWeightInspectionStatus.success) {
              if (state.vehicle_weight_inspection_list != null && state.vehicle_weight_inspection_list!.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.all(20.h),
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      barTouchData: barTouchData,
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
                            getTitlesWidget: (value, meta) {
                              final buddhistDate = state.vehicle_weight_inspection_list![value.toInt()].createDate ?? '';
                              List<String> parts = buddhistDate.split("/");
                              String dayMonth = "${parts[0]}/${parts[1]}";
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  dayMonth,
                                  style: state.vehicle_weight_inspection_list!.length - 1 == value.toInt() ? AppTextStyle.label12bold() : AppTextStyle.label12normal(),
                                ),
                              );
                            },
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
                      barGroups: state.total_chart_list,
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }
            return SkeletionContainerWidget(
              height: 180.h,
            );
          },
        ),
      );
    });
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(rod.toY.round().toString(), AppTextStyle.label12bold());
          },
        ),
      );
}
