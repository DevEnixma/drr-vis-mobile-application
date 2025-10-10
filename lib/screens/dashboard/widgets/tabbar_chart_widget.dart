import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wts_bloc/blocs/dashboard/dashboard_bloc.dart';

import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/text_style.dart';
import 'charts/bar_chart_widget.dart';
import 'charts/line_chart_widget.dart';

class TabbarChartWidget extends StatefulWidget {
  const TabbarChartWidget({super.key});

  @override
  State<TabbarChartWidget> createState() => _TabbarChartWidgetState();
}

class _TabbarChartWidgetState extends State<TabbarChartWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      // Set state to update the AnimatedSmoothIndicator when tab index changes
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AspectRatio(
        aspectRatio: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 0.85.h : 1.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: TabBar(
                tabAlignment: TabAlignment.center,
                dividerColor: Theme.of(context).colorScheme.tertiaryContainer,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.onTertiary,
                indicatorWeight: 3,
                labelStyle: AppTextStyle.title16bold(),
                controller: _tabController,
                tabs: const [
                  Tab(text: 'ผลการตรวจสอบน้ำหนัก'),
                  Tab(text: 'แผนและผลการจัดตั้ง'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      SizedBox(height: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 15.h : 15.h),
                      Text('ผลการตรวจสอบน้ำหนักทั้งหมด', style: AppTextStyle.title18bold()),
                      Text(
                        'ผลการดำเนินการจัดตั้ง 7 วันล่าสุด',
                        style: AppTextStyle.title14normal(),
                      ),
                      BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          if (state.vehicleWeightInspectionBarChart != null) {
                            return BarChartWidget(
                              items: state.vehicleWeightInspectionBarChart!,
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 15.h : 15.h),
                      Text('แผนและผลการจัดตั้งหน่วยชั่งเคลื่อนที่', style: AppTextStyle.title18bold()),
                      BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          if (state.dashboardViewSumPlanChartStatus == DashboardViewSumPlanChart.success) {
                            return Text(
                              'ประจำปีงบประมาณ ${state.planChartYear ?? ''}',
                              style: AppTextStyle.title14normal(),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          if (state.dashboardViewSumPlanChart != null && state.dashboardViewSumPlanChart!.isNotEmpty) {
                            return LineChartWidget(
                              items: state.dashboardViewSumPlanChart ?? [],
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: _tabController.index,
              count: 2, // Number of tabs
              effect: SlideEffect(
                spacing: 8.0,
                radius: 14.0.r,
                dotWidth: 8.0.h,
                dotHeight: 8.0.h,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1.5,
                dotColor: Theme.of(context).colorScheme.tertiaryContainer,
                activeDotColor: ColorApps.grayDot,
              ),
            ),
          ],
        ),
      );
    });
  }
}
