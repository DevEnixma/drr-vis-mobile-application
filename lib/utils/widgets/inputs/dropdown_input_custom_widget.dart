import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_app.dart';
import '../../constants/text_style.dart';

class DropdownInputCustomWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? isMultiLine;
  final bool? isDisable;
  final Function() onTap;

  const DropdownInputCustomWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.isMultiLine,
    this.isDisable,
    required this.onTap,
  });

  @override
  State<DropdownInputCustomWidget> createState() => _DropdownInputCustomWidgetState();
}

class _DropdownInputCustomWidgetState extends State<DropdownInputCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode != null ? widget.focusNode : null,
        enabled: false,
        style: AppTextStyle.title18normal(),
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        decoration: InputDecoration(
          hintText: "กรุณาเลือก",
          hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
          isDense: true,
          filled: true,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
            color: ColorApps.iconColor,
          ),
          fillColor: widget.isDisable != null && widget.isDisable! == true ? ColorApps.colorGray : Theme.of(context).colorScheme.surface,
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: ColorApps.grayBorder)),
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
          errorStyle: AppTextStyle.label12bold(color: Theme.of(context).colorScheme.error),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            // ตรวจสอบถ้าเป็นค่าว่าง
            if (widget.focusNode != null) {
              widget.focusNode!.requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
              return "กรุณาเลือก";
            }
          }
          return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
        },
      ),
    );
  }
}
