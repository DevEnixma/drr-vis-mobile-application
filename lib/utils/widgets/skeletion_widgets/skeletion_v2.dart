import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/color_app.dart';

class SkeletionV2 extends StatelessWidget {
  const SkeletionV2({
    super.key,
    this.width,
    required this.height,
    this.baseColor,
    this.highlightColor,
    this.color,
    this.useRadiusAll,
    this.radiusAll,
  });

  final double? width;
  final double? height;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? color;
  final bool? useRadiusAll;
  final double? radiusAll;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color ?? ColorApps.grayBorder),
          color: Colors.grey.shade300,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
