import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';
import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart';

class ShartType6123456Widget extends StatefulWidget {
  const ShartType6123456Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft12,
    required this.shaft34,
    required this.shaft56,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft12, shaft34, shaft56;
  final bool? isDisable;

  @override
  State<ShartType6123456Widget> createState() => _ShartType6123456WidgetState();
}

class _ShartType6123456WidgetState extends State<ShartType6123456Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;
  bool isShowIconError5 = false;
  bool isShowIconError6 = false;

  bool isOverShaft = false;
  bool isOverShaft12 = false;
  bool isOverShaft34 = false;
  bool isOverShaft56 = false;

  void shaft1(String value) {
    calOverShaft();
  }

  void shaft2(String value) {
    calOverShaft();
  }

  void shaft3(String value) {
    calOverShaft();
  }

  void shaft4(String value) {
    calOverShaft();
  }

  void shaft5(String value) {
    calOverShaft();
  }

  void shaft6(String value) {
    calOverShaft();
  }

  void calOverShaft() {
    // Calculate shaft 1 + shaft 2
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;
    double result12 = shaft1 + shaft2;

    if (widget.shaft12 < result12) {
      setState(() {
        isShowIconError1 = true;
        isShowIconError2 = true;
        isOverShaft12 = true;
      });
    } else {
      setState(() {
        isShowIconError1 = false;
        isShowIconError2 = false;
        isOverShaft12 = false;
      });
    }

    // Calculate shaft 3 + shaft 4
    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;
    double result34 = shaft3 + shaft4;

    if (widget.shaft34 < result34) {
      setState(() {
        isShowIconError3 = true;
        isShowIconError4 = true;
        isOverShaft34 = true;
      });
    } else {
      setState(() {
        isShowIconError3 = false;
        isShowIconError4 = false;
        isOverShaft34 = false;
      });
    }

    // Calculate shaft 5 + shaft 6
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;
    double shaft6 = widget.carDriveShaftController[5].text != ''
        ? double.parse(widget.carDriveShaftController[5].text)
        : 0;
    double result56 = shaft5 + shaft6;

    if (widget.shaft56 < result56) {
      setState(() {
        isShowIconError5 = true;
        isShowIconError6 = true;
        isOverShaft56 = true;
      });
    } else {
      setState(() {
        isShowIconError5 = false;
        isShowIconError6 = false;
        isOverShaft56 = false;
      });
    }

    // Set overall overShaft status
    if (isOverShaft12 == true &&
        isOverShaft34 == true &&
        isOverShaft56 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft12 || isOverShaft34 || isOverShaft56) {
        isOverShaft = true;
      } else {
        isOverShaft = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 26.w,
      runSpacing: 12.w,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 1',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[0],
                focusNode: widget.carDriveShaftFocusNode[0],
                isShowIconError: isShowIconError1,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
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
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 2',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[1],
                focusNode: widget.carDriveShaftFocusNode[1],
                isShowIconError: isShowIconError2,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft2(value);
                  }
                  widget.onTextChange!(value, 'ds_2', isOverShaft);
                },
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 3',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[2],
                focusNode: widget.carDriveShaftFocusNode[2],
                isShowIconError: isShowIconError3,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft3(value);
                  }
                  widget.onTextChange!(value, 'ds_3', isOverShaft);
                },
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 4',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[3],
                focusNode: widget.carDriveShaftFocusNode[3],
                isShowIconError: isShowIconError4,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft4(value);
                  }
                  widget.onTextChange!(value, 'ds_4', isOverShaft);
                },
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 5',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[4],
                focusNode: widget.carDriveShaftFocusNode[4],
                isShowIconError: isShowIconError5,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft5(value);
                  }
                  widget.onTextChange!(value, 'ds_5', isOverShaft);
                },
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150,
            maxWidth: MediaQuery.of(context).size.width / 2 - 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInputWidget(
                title: 'น้ำหนักเพลาที่ 6',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[5],
                focusNode: widget.carDriveShaftFocusNode[5],
                isShowIconError: isShowIconError6,
                isDisable: widget.isDisable,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft6(value);
                  }
                  widget.onTextChange!(value, 'ds_6', isOverShaft);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
