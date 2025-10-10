import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingPagination extends StatelessWidget {
  const CustomLoadingPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Theme.of(context).colorScheme.primary,
        rightDotColor: Theme.of(context).colorScheme.onSurface,
        size: 30.h,
      ),
    );
  }
}
