import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';

class TitleCardWidget extends StatefulWidget {
  const TitleCardWidget({
    super.key,
  });

  @override
  State<TitleCardWidget> createState() => _TitleCardWidgetState();
}

class _TitleCardWidgetState extends State<TitleCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.dashboardSumVehicleStatus ==
              DashboardSumVehicleStatus.success) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.dailyWeighedVehiclesSum?.total ?? 0} คัน',
                          style: AppTextStyle.title20bold()),
                      Text(
                        'จำนวนรถเข้าชั่ง',
                        style: AppTextStyle.title14normal(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.dailyWeighedVehiclesSum?.over ?? 0} คัน',
                          style: AppTextStyle.title20bold(
                              color: Theme.of(context).colorScheme.error)),
                      Text(
                        'บรรทุกเกิน',
                        style: AppTextStyle.title14normal(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                    child: Image.asset(
                      'assets/images/dashboard.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            );
          }
          return SkeletionContainerWidget(
            height: 52.h,
          );
        },
      ),
    );
  }
}
