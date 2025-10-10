import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';
import '../../../../../utils/widgets/inputs/label_input_widget.dart';

class ShartType5Widget extends StatefulWidget {
  const ShartType5Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft1,
    required this.shaft23,
    required this.shaft45,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft1, shaft23, shaft45;
  final bool? isDisable;

  @override
  State<ShartType5Widget> createState() => _ShartType5WidgetState();
}

class _ShartType5WidgetState extends State<ShartType5Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;
  bool isShowIconError5 = false;

  bool isOverShaft = false;
  bool isOverShaft1 = false;
  bool isOverShaft23 = false;
  bool isOverShaft45 = false;

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

  void shaft23(String value) {
    double shaft2 = widget.carDriveShaftController[1].text != '' ? double.parse(widget.carDriveShaftController[1].text) : 0;
    double shaft3 = widget.carDriveShaftController[2].text != '' ? double.parse(widget.carDriveShaftController[2].text) : 0;

    double result = shaft2 + shaft3;
    if (widget.shaft23 < result) {
      setState(() {
        isShowIconError2 = true;
        isShowIconError3 = true;
      });
    } else {
      setState(() {
        isShowIconError2 = false;
        isShowIconError3 = false;
      });
    }

    calOverShaft();
  }

  void shaft45(String value) {
    double shaft4 = widget.carDriveShaftController[3].text != '' ? double.parse(widget.carDriveShaftController[3].text) : 0;
    double shaft5 = widget.carDriveShaftController[4].text != '' ? double.parse(widget.carDriveShaftController[4].text) : 0;

    double result = shaft4 + shaft5;
    if (widget.shaft45 < result) {
      setState(() {
        isShowIconError4 = true;
        isShowIconError5 = true;
      });
    } else {
      setState(() {
        isShowIconError4 = false;
        isShowIconError5 = false;
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
    double shaft3 = widget.carDriveShaftController[2].text != '' ? double.parse(widget.carDriveShaftController[2].text) : 0;

    double result2 = shaft2 + shaft3;
    if (widget.shaft23 < result2) {
      setState(() {
        isOverShaft23 = true;
      });
    } else {
      setState(() {
        isOverShaft23 = false;
      });
    }

    double shaft4 = widget.carDriveShaftController[3].text != '' ? double.parse(widget.carDriveShaftController[3].text) : 0;
    double shaft5 = widget.carDriveShaftController[4].text != '' ? double.parse(widget.carDriveShaftController[4].text) : 0;

    double result3 = shaft4 + shaft5;
    if (widget.shaft45 < result3) {
      setState(() {
        isOverShaft45 = true;
      });
    } else {
      setState(() {
        isOverShaft45 = false;
      });
    }

    if (isOverShaft1 == true && isOverShaft23 == true && isOverShaft45 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft1 || isOverShaft23 || isOverShaft45) {
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
                    shaft23(value);
                  }
                  widget.onTextChange!(value, 'ds_2', isOverShaft);
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
                title: 'น้ำหนักเพลาที่ 3',
                isRequired: true,
              ),
              TextFormField(
                controller: widget.carDriveShaftController[2],
                focusNode: widget.carDriveShaftFocusNode[2],
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
                  suffixIcon: isShowIconError3
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
                    if (widget.carDriveShaftFocusNode[2] != null) {
                      widget.carDriveShaftFocusNode[2].requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
                      return "กรุณากรอกข้อมูล";
                    }
                  }
                  return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
                },
                onChanged: (value) {
                  if (value != null) {
                    shaft23(value);
                  }
                  widget.onTextChange!(value, 'ds_3', isOverShaft);
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
                title: 'น้ำหนักเพลาที่ 4',
                isRequired: true,
              ),
              TextFormField(
                controller: widget.carDriveShaftController[3],
                focusNode: widget.carDriveShaftFocusNode[3],
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
                  suffixIcon: isShowIconError4
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
                    if (widget.carDriveShaftFocusNode[3] != null) {
                      widget.carDriveShaftFocusNode[3].requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
                      return "กรุณากรอกข้อมูล";
                    }
                  }
                  return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
                },
                onChanged: (value) {
                  if (value != null) {
                    shaft45(value);
                  }
                  widget.onTextChange!(value, 'ds_4', isOverShaft);
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
                title: 'น้ำหนักเพลาที่ 5',
                isRequired: true,
              ),
              TextFormField(
                controller: widget.carDriveShaftController[4],
                focusNode: widget.carDriveShaftFocusNode[4],
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
                  suffixIcon: isShowIconError5
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
                    if (widget.carDriveShaftFocusNode[4] != null) {
                      widget.carDriveShaftFocusNode[4].requestFocus(); // Auto-focus กลับไปที่ฟิลด์นี้
                      return "กรุณากรอกข้อมูล";
                    }
                  }
                  return null; // ถ้าถูกต้องไม่คืนค่าใดๆ
                },
                onChanged: (value) {
                  if (value != null) {
                    shaft45(value);
                  }
                  widget.onTextChange!(value, 'ds_5', isOverShaft);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
