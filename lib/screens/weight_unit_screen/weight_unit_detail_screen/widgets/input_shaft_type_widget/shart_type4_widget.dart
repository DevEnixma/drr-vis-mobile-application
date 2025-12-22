import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart';

class ShartType4Widget extends StatefulWidget {
  const ShartType4Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft12,
    required this.shaft34,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft12, shaft34;
  final bool? isDisable;

  @override
  State<ShartType4Widget> createState() => _ShartType4WidgetState();
}

class _ShartType4WidgetState extends State<ShartType4Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;

  bool isOverShaft = false;
  bool isOverShaft12 = false;
  bool isOverShaft34 = false;

  void shaft12(String value) {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;

    double result = shaft1 + shaft2;
    if (widget.shaft12 < result) {
      setState(() {
        isShowIconError1 = true;
        isShowIconError2 = true;
      });
    } else {
      setState(() {
        isShowIconError1 = false;
        isShowIconError2 = false;
      });
    }

    calOverShaft();
  }

  void shaft34(String value) {
    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;

    double result = shaft3 + shaft4;
    if (widget.shaft34 < result) {
      setState(() {
        isShowIconError3 = true;
        isShowIconError4 = true;
      });
    } else {
      setState(() {
        isShowIconError3 = false;
        isShowIconError4 = false;
      });
    }

    calOverShaft();
  }

  void calOverShaft() {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;

    double result = shaft1 + shaft2;
    if (widget.shaft12 < result) {
      setState(() {
        isOverShaft12 = true;
      });
    } else {
      setState(() {
        isOverShaft12 = false;
      });
    }

    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;

    double result2 = shaft4 + shaft3;
    if (widget.shaft34 < result2) {
      setState(() {
        isOverShaft34 = true;
      });
    } else {
      setState(() {
        isOverShaft34 = false;
      });
    }

    if (isOverShaft12 == true && isOverShaft34 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft12 || isOverShaft34) {
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
                    shaft12(value);
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
                    shaft12(value);
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
                    shaft34(value);
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
                    shaft34(value);
                  }
                  widget.onTextChange!(value, 'ds_4', isOverShaft);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
