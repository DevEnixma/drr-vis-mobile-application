import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';
import '../../../../../utils/widgets/inputs/label_input_widget.dart';

class ShartType2Widget extends StatefulWidget {
  const ShartType2Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft1,
    required this.shaft2,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft1, shaft2;
  final bool? isDisable;

  @override
  State<ShartType2Widget> createState() => _ShartType2WidgetState();
}

class _ShartType2WidgetState extends State<ShartType2Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;

  bool isOverShaft = false;
  bool isOverShaft1 = false;
  bool isOverShaft2 = false;

  void shaft1(String value) {
    double shaft1 = widget.carDriveShaftController[0].text != '' ? double.parse(widget.carDriveShaftController[0].text) : 0;

    double result = shaft1;
    if (widget.shaft1 < result) {
      setState(() {
        isShowIconError1 = true;
      });
    } else {
      setState(() {
        isShowIconError1 = false;
      });
    }

    calOverShaft();
  }

  void shaft2(String value) {
    double shaft2 = widget.carDriveShaftController[1].text != '' ? double.parse(widget.carDriveShaftController[1].text) : 0;

    double result = shaft2;
    if (widget.shaft2 < result) {
      setState(() {
        isShowIconError2 = true;
      });
    } else {
      setState(() {
        isShowIconError2 = false;
      });
    }

    calOverShaft();
  }

  void calOverShaft() {
    double shaft1 = widget.carDriveShaftController[0].text != '' ? double.parse(widget.carDriveShaftController[0].text) : 0;

    double result1 = shaft1;
    if (widget.shaft1 < result1) {
      setState(() {
        isOverShaft1 = true;
      });
    } else {
      setState(() {
        isOverShaft1 = false;
      });
    }

    double shaft2 = widget.carDriveShaftController[1].text != '' ? double.parse(widget.carDriveShaftController[1].text) : 0;

    double result2 = shaft2;
    if (widget.shaft2 < result2) {
      setState(() {
        isOverShaft2 = true;
      });
    } else {
      setState(() {
        isOverShaft2 = false;
      });
    }

    if (isOverShaft1 == true && isOverShaft2 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft1 || isOverShaft2) {
        isOverShaft = true;
      } else {
        isOverShaft = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 26.w, // Horizontal space between fields
      runSpacing: 12.w, // Vertical space between rows
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150, // Minimum width for each field
            maxWidth: MediaQuery.of(context).size.width / 2 - 32, // To have 2 columns
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 1',
                isRequired: true,
              ),
              TextFormField(
                controller: widget.carDriveShaftController[0],
                focusNode: widget.carDriveShaftFocusNode[0],
                style: AppTextStyle.title18normal(),
                cursorColor: Theme.of(context).colorScheme.onSecondary,
                enabled: widget.isDisable != null ? false : true,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                  isDense: true,
                  filled: true,
                  fillColor: widget.isDisable != null ? ColorApps.colorGray : Theme.of(context).colorScheme.surface,
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
                  suffixIcon: isShowIconError1
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
                    // ตรวจสอบถ้าเป็นค่าว่าง
                    if (widget.carDriveShaftFocusNode[0] != null) {
                      widget.carDriveShaftFocusNode[0].requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
                      return "กรุณากรอกข้อมูล";
                    }
                  }
                  return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
                },
                onChanged: (value) {
                  if (value != null) {
                    shaft1(value);
                  }
                  widget.onTextChange!(value, 'ds_1', isOverShaft);
                },
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150, // Minimum width for each field
            maxWidth: MediaQuery.of(context).size.width / 2 - 32, // To have 2 columns
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 2',
                isRequired: true,
              ),
              TextFormField(
                controller: widget.carDriveShaftController[1],
                focusNode: widget.carDriveShaftFocusNode[1],
                style: AppTextStyle.title18normal(),
                cursorColor: Theme.of(context).colorScheme.onSecondary,
                enabled: widget.isDisable != null ? false : true,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                  isDense: true,
                  filled: true,
                  fillColor: widget.isDisable != null ? ColorApps.colorGray : Theme.of(context).colorScheme.surface,
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
                  suffixIcon: isShowIconError2
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
                    // ตรวจสอบถ้าเป็นค่าว่าง
                    if (widget.carDriveShaftFocusNode[1] != null) {
                      widget.carDriveShaftFocusNode[1].requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
                      return "กรุณากรอกข้อมูล";
                    }
                  }
                  return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
                },
                onChanged: (value) {
                  if (value != null) {
                    shaft2(value);
                  }
                  widget.onTextChange!(value, 'ds_2', isOverShaft);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
