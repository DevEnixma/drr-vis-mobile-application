import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_app.dart';
import '../constants/text_style.dart';
import '../libs/string_helper.dart';

class TagCarOverWeightWidget extends StatelessWidget {
  const TagCarOverWeightWidget({
    super.key,
    required this.isOverWeight,
    required this.isOverWeightDesc,
  });

  final String isOverWeight;
  final String isOverWeightDesc;

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      switch (StringHleper.checkString(isOverWeight)) {
        case 'Y':
          return Theme.of(context).colorScheme.error;
        case 'P':
          return ColorApps.contentColorOrenge;
        case 'N':
        default:
          return Theme.of(context).colorScheme.tertiary;
      }
    }

    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          // color: StringHleper.checkString(isOverWeight) == 'N' ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.error,
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(5.r),
        ),
        margin: const EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.only(right: 12, left: 12, top: 4, bottom: 4),
        child: Center(
          child: Text(
            StringHleper.checkString(isOverWeightDesc),
            style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.surface),
          ),
        ),
      ),
    );
  }
}
