import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_app.dart';
import '../constants/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  CustomTextField({
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextStyle.title16bold(),
            children: <TextSpan>[
              TextSpan(
                text: '',
                style: AppTextStyle.title18normal(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: controller,
          style: AppTextStyle.title18normal(),
          cursorColor: Theme.of(context).colorScheme.onSecondary,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: ColorApps.grayBorder)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onTertiary,
                  width: 1,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: ColorApps.grayBorder,
                  width: 1,
                )),
          ),
        ),
        SizedBox(height: 12.w),
      ],
    );
  }
}

class CustomTextfieldSelect extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function() onTap;

  CustomTextfieldSelect({
    required this.title,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextStyle.title16bold(),
            children: <TextSpan>[
              TextSpan(
                text: '',
                style: AppTextStyle.title18normal(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            readOnly: true,
            controller: controller,
            enabled: false,
            style: AppTextStyle.title18normal(),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              hintText: '',
              hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: ColorApps.iconColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onTertiary,
                    width: 1,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onTertiary,
                    width: 1,
                  )),
            ),
          ),
        ),
        SizedBox(height: 12.0),
      ],
    );
  }
}
