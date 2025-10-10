import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes/routes.dart';
import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../../widgets/empty_widget.dart';

class TopRouterBar extends StatefulWidget {
  const TopRouterBar({super.key});

  @override
  State<TopRouterBar> createState() => _TopRouterBarState();
}

class _TopRouterBarState extends State<TopRouterBar> {
  String roadCode = '';
  void getRoadCodeDetail(String value) {
    setState(() {
      roadCode = value;
    });

    goToScreen();
  }

  void goToScreen() {
    Routes.gotoOpenStreetMap(context, roadCode);
  }

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 400),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.topFiveRoadStatus == TopFiveRoadStatus.success) {
            if (state.topFiveRoad != null && state.topFiveRoad!.isNotEmpty) {
              return SizedBox(
                // height: 350.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.topFiveRoad!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        getRoadCodeDetail(state.topFiveRoad![index].roadCode!);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
                        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 18.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: ColorApps.grayBorder),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.topFiveRoad![index].roadCode ?? '',
                                    style: AppTextStyle.title18boldUnderLine(),
                                  ),
                                  Text(
                                    '${state.topFiveRoad![index].totalVehicles} คัน',
                                    style: AppTextStyle.title18normal(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6.h),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  trackHeight: 5.0.h,
                                  trackShape: const RectangularSliderTrackShape(),
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 5.h,
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 8.h,
                                  ),
                                  activeTrackColor: Theme.of(context).colorScheme.primary,
                                  inactiveTrackColor: Theme.of(context).colorScheme.primary,
                                  disabledThumbColor: Theme.of(context).colorScheme.primary,
                                  disabledActiveTrackColor: Theme.of(context).colorScheme.primary),
                              child: Slider(
                                activeColor: Theme.of(context).colorScheme.primary,
                                value: double.parse(state.topFiveRoad![index].percentage ?? '0'),
                                max: 100,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return EmptyWidget(
                title: 'ไม่พบข้อมูล',
                label: '',
              );
            }
          }
          return Column(
            children: [
              SkeletionContainerWidget(
                height: 65.h,
              ),
              SkeletionContainerWidget(
                height: 65.h,
              ),
              SkeletionContainerWidget(
                height: 65.h,
              ),
              SkeletionContainerWidget(
                height: 65.h,
              ),
              SkeletionContainerWidget(
                height: 65.h,
              ),
            ],
          );
        },
      ),
    );
  }
}
