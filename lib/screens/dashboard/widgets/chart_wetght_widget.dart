import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/profile/profile_bloc.dart';
import 'tabbar_chart_widget.dart';

class ChartWetghtWidget extends StatefulWidget {
  const ChartWetghtWidget({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  State<ChartWetghtWidget> createState() => _ChartWetghtWidgetState();
}

class _ChartWetghtWidgetState extends State<ChartWetghtWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // if (state.profileStatus == ProfileStatus.loading) {}
          // if (state.profileStatus == ProfileStatus.success) {
          //   if (state.profile != null && state.profile!.username != null) {
          // Chart ตอน login
          return Column(
            children: [
              const TabbarChartWidget(),
              SizedBox(height: widget.constraints.maxWidth > 400 && widget.constraints.maxWidth < 600 ? 15.h : 30.h),
            ],
          );
          //   } else {
          //     return Column(
          //       children: [
          //         Text('ผลการตรวจสอบน้ำหนักทั้งหมด', style: AppTextStyle.title18bold()),
          //         Text(
          //           'ผลการดำเนินการจัดตั้ง 7 วันล่าสุด',
          //           style: AppTextStyle.title14normal(),
          //         ),
          //         const BarChartGuest(),
          //       ],
          //     );
          //   }
          // }

          // if (state.profileStatus == ProfileStatus.error && state.profileError != '') {
          //   // showSnackbarBottom(context, state.profileError.toString());
          //   // return const SizedBox.shrink();
          //   return Column(
          //     children: [
          //       Text('ผลการตรวจสอบน้ำหนักทั้งหมด', style: AppTextStyle.title18bold()),
          //       Text(
          //         'ผลการดำเนินการจัดตั้ง 7 วันล่าสุด',
          //         style: AppTextStyle.title14normal(),
          //       ),
          //       const BarChartGuest(),
          //     ],
          //   );
          // }

          // return Column(
          //   children: [
          //     Text('ผลการตรวจสอบน้ำหนักทั้งหมด', style: AppTextStyle.title18bold()),
          //     Text(
          //       'ผลการดำเนินการจัดตั้ง 7 วันล่าสุด',
          //       style: AppTextStyle.title14normal(),
          //     ),
          //     const BarChartGuest(),
          //   ],
          // );
        },
      ),
    );
  }
}
