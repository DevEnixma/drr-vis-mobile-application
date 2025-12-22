import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart';

class ShartType5345Widget extends StatefulWidget {
  const ShartType5345Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft1,
    required this.shaft2,
    required this.shaft345,
    this.isDisable,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft1, shaft2, shaft345;
  final bool? isDisable;

  @override
  State<ShartType5345Widget> createState() => _ShartType5345WidgetState();
}

class _ShartType5345WidgetState extends State<ShartType5345Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;
  bool isShowIconError5 = false;

  bool isOverShaft = false;
  bool isOverShaft1 = false;
  bool isOverShaft2 = false;
  bool isOverShaft345 = false;

  void shaft1(String value) {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;

    double resul1 = shaft1;
    if (widget.shaft1 < resul1) {
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

    double result2 = shaft2;
    if (widget.shaft2 < result2) {
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

  void shaft345(String value) {
    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;

    double result3 = shaft4 + shaft5 + shaft3;
    if (widget.shaft345 < result3) {
      setState(() {
        isShowIconError3 = true;
        isShowIconError4 = true;
        isShowIconError5 = true;
      });
    } else {
      setState(() {
        isShowIconError3 = false;
        isShowIconError4 = false;
        isShowIconError5 = false;
      });
    }

    calOverShaft();
  }

  void calOverShaft() {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;

    double resul1 = shaft1;
    if (widget.shaft1 < resul1) {
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

    double shaft3 = widget.carDriveShaftController[2].text != ''
        ? double.parse(widget.carDriveShaftController[2].text)
        : 0;
    double shaft4 = widget.carDriveShaftController[3].text != ''
        ? double.parse(widget.carDriveShaftController[3].text)
        : 0;
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;

    double result3 = shaft4 + shaft5 + shaft3;
    if (widget.shaft345 < result3) {
      setState(() {
        isOverShaft345 = true;
      });
    } else {
      setState(() {
        isOverShaft345 = false;
      });
    }

    if (isOverShaft1 == true &&
        isOverShaft2 == true &&
        isOverShaft345 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft1 || isOverShaft2 || isOverShaft345) {
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
                    shaft345(value);
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
                    shaft345(value);
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
                    shaft345(value);
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
