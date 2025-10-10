import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/text_style.dart';
import '../login/login_screen.dart';

class TestScreen extends StatefulWidget {
  final String title;
  const TestScreen({super.key, required this.title});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  final List<double> values = [5, 16, 18, 20, 17, 19, 10];
  bool showingTooltip = false;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, values[0]);
    final barGroup2 = makeGroupData(1, values[1]);
    final barGroup3 = makeGroupData(2, values[2]);
    final barGroup4 = makeGroupData(3, values[3]);
    final barGroup5 = makeGroupData(4, values[4]);
    final barGroup6 = makeGroupData(5, values[5]);
    final barGroup7 = makeGroupData(6, values[6]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Theme.of(context).colorScheme.primary,
          width: 35.w,
          borderRadius: BorderRadius.circular(6.r),
        ),
      ],
      // showingTooltipIndicators: touchedGroupIndex != null ? [touchedGroupIndex!] : [],
      // barsSpace: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/iconamoon_profile-fill.svg',
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.primary,
                    width: 22,
                  ),
                  Text('ไปหน้าล็อคอิน', style: AppTextStyle.title18bold()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
