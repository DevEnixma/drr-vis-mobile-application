import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';

class ShaftTextFieldWidget extends StatelessWidget {
  const ShaftTextFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.isShowIconError,
    this.isDisable,
  });

  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final bool isShowIconError;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: AppTextStyle.title18normal(),
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      enabled: isDisable != null ? false : true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
        isDense: true,
        filled: true,
        fillColor: isDisable != null
            ? ColorApps.colorGray
            : Theme.of(context).colorScheme.surface,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: ColorApps.grayBorder),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onTertiary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: ColorApps.grayBorder,
            width: 1,
          ),
        ),
        errorStyle: AppTextStyle.label12bold(
            color: Theme.of(context).colorScheme.error),
        suffixIcon: isShowIconError
            ? IconButton(
                icon: Icon(
                  Icons.error,
                  color: ColorApps.colorRed,
                  size: 25,
                ),
                onPressed: () {},
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          focusNode.requestFocus();
          return "กรุณากรอกข้อมูล";
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
