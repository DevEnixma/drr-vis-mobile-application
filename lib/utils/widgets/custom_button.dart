import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_style.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final bool disable;
  final Widget? detailbutton;
  final void Function()? onPressed; // ถ้า disable เป็น true ไม่ต้องมี onpressed ก็ได้

  const CustomeButton({
    super.key,
    this.text = '',
    this.disable = false,
    this.onPressed,
    this.detailbutton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36.h,
      child: ElevatedButton(
        onPressed: (!disable) ? onPressed ?? () {} : null,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0.r)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.6);
            }
            return Theme.of(context).colorScheme.primary;
          }),
        ),
        child: detailbutton ??
            Text(
              text,
              style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
            ),
      ),
    );
  }
}
