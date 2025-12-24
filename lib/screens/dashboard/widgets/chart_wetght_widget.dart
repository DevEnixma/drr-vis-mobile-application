import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tabbar_chart_widget.dart';

class ChartWetghtWidget extends StatelessWidget {
  const ChartWetghtWidget({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabbarChartWidget(),
        SizedBox(
          height: constraints.maxWidth > 400 && constraints.maxWidth < 600
              ? 15.h
              : 30.h,
        ),
      ],
    );
  }
}
