import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/main.dart';

import '../../constants/color_app.dart';
import '../../constants/text_style.dart';

class TextInputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? isMultiLine;
  final bool? isDisable;
  final TextInputType? keyBoardType;
  final Function(String, String)? onTextChange; // Callback สำหรับส่งสองค่าไปที่ Parent
  final bool? isCustomStyleColorText;
  final Color? customStyleColorText;
  final bool? isSuffixIcon;
  final double? isCalDriveShaft;
  final bool? isDs;
  final bool? isShowIconError2;
  final IconData? iconName;
  final Color? iconColor;
  final Color? isDisableBgColor;

  TextInputWidget({
    required this.label,
    required this.hint,
    required this.controller,
    this.focusNode,
    this.isMultiLine,
    this.isDisable,
    this.keyBoardType,
    this.onTextChange,
    this.isCustomStyleColorText,
    this.customStyleColorText,
    this.isSuffixIcon,
    this.isCalDriveShaft,
    this.isDs,
    this.isShowIconError2,
    this.iconName,
    this.iconColor,
    this.isDisableBgColor,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late bool isShowIconError;

  @override
  void initState() {
    super.initState();
    isShowIconError = widget.isShowIconError2 ?? false;
  }

  Widget build(BuildContext context) {
    setState(() {
      isShowIconError = widget.isShowIconError2 ?? false;
    });
    if (widget.isDs != null) {
      if (widget.controller.text != '' && widget.isCalDriveShaft! > 0) {
        if (widget.isCalDriveShaft! < double.parse(widget.controller.text)) {
          setState(() {
            isShowIconError = true;
          });
        } else {
          setState(() {
            isShowIconError = false;
          });
        }
      }
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode != null ? widget.focusNode : null,
      maxLines: widget.isMultiLine != null ? 60 ~/ 20 : null, // multi line
      enabled: widget.isDisable != null ? false : true, // Disable input
      maxLength: widget.isMultiLine != null ? 255 : null,
      keyboardType: widget.keyBoardType != null ? widget.keyBoardType : null,
      style: widget.isCustomStyleColorText != null ? AppTextStyle.title16bold(color: widget.customStyleColorText) : AppTextStyle.title18normal(),
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
        isDense: true,
        filled: true,
        fillColor: widget.isDisable != null ? widget.isDisableBgColor ?? ColorApps.colorGray : Theme.of(context).colorScheme.surface,
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
        errorStyle: AppTextStyle.label12bold(color: Theme.of(context).colorScheme.error),
        suffixIcon: widget.isSuffixIcon != null && isShowIconError
            ? IconButton(
                icon: Icon(
                  widget.iconName ?? Icons.error,
                  color: widget.iconColor ?? ColorApps.colorRed,
                  size: 25,
                ),
                onPressed: () {},
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          // ตรวจสอบถ้าเป็นค่าว่าง
          if (widget.focusNode != null) {
            widget.focusNode!.requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
            return "กรุณากรอกข้อมูล";
          }
        }
        return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
      },
      onChanged: (value) {
        try {
          if (widget.onTextChange != null) {
            if (widget.isCalDriveShaft != null && value != null) {
              if (widget.isCalDriveShaft! < double.parse(value)) {
                setState(() {
                  isShowIconError = true;
                });
              } else {
                setState(() {
                  isShowIconError = false;
                });
              }
            }
            widget.onTextChange!(value, widget.label); // เรียก Callback เมื่อไม่เป็น null
          }
        } catch (e) {
          logger.e('===test===> $e');
        }
      },
    );
  }
}
