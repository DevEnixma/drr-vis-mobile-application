import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';
import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart'; // Import ShaftTextFieldWidget

class ShartType6Widget extends StatefulWidget {
  const ShartType6Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft1,
    required this.shaft23,
    required this.shaft456,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft1, shaft23, shaft456;
  final bool? isDisable;

  @override
  State<ShartType6Widget> createState() => _ShartType6WidgetState();
}

class _ShartType6WidgetState extends State<ShartType6Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;
  bool isShowIconError5 = false;
  bool isShowIconError6 = false;

  bool isOverShaft = false;
  bool isOverShaft1 = false;
  bool isOverShaft23 = false;
  bool isOverShaft456 = false;

  void shaft1(String value) {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;

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
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;
    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;

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

  void shaft456(String value) {
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;
    double shaft6 = widget.carDriveShaftController[5].text != ''
        ? double.parse(widget.carDriveShaftController[5].text)
        : 0;

    double result = shaft4 + shaft5 + shaft6;
    if (widget.shaft456 < result) {
      setState(() {
        isShowIconError4 = true;
        isShowIconError5 = true;
        isShowIconError6 = true;
      });
    } else {
      setState(() {
        isShowIconError4 = false;
        isShowIconError5 = false;
        isShowIconError6 = false;
      });
    }

    calOverShaft();
  }

  void calOverShaft() {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;

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

    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;
    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;

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

    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;
    double shaft6 = widget.carDriveShaftController[5].text != ''
        ? double.parse(widget.carDriveShaftController[5].text)
        : 0;

    double result3 = shaft4 + shaft5 + shaft6;
    if (widget.shaft456 < result3) {
      setState(() {
        isOverShaft456 = true;
      });
    } else {
      setState(() {
        isOverShaft456 = false;
      });
    }

    if (isOverShaft1 == true &&
        isOverShaft23 == true &&
        isOverShaft456 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft1 || isOverShaft23 || isOverShaft456) {
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
                    shaft456(value);
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
                    shaft456(value);
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
                    shaft456(value);
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
