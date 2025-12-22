import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart';

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

  void shaft2(String value) {
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;

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
      ],
    );
  }
}
