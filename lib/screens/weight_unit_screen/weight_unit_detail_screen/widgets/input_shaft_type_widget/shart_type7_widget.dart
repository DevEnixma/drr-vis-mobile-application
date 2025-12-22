import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_app.dart';
import '../../../../../utils/constants/text_style.dart';
import '../../../../../utils/widgets/inputs/label_input_widget.dart';
import 'shaft_text_field_widget.dart'; // Import ShaftTextFieldWidget

class ShartType7Widget extends StatefulWidget {
  const ShartType7Widget({
    super.key,
    required this.hint,
    required this.carDriveShaftController,
    required this.carDriveShaftFocusNode,
    required this.onTextChange,
    required this.shaft12,
    required this.shaft34,
    required this.shaft5,
    required this.shaft67,
  });

  final String hint;
  final List<TextEditingController> carDriveShaftController;
  final List<FocusNode> carDriveShaftFocusNode;
  final Function(String, String, bool)? onTextChange;
  final int shaft12, shaft34, shaft5, shaft67;

  @override
  State<ShartType7Widget> createState() => _ShartType7WidgetState();
}

class _ShartType7WidgetState extends State<ShartType7Widget> {
  bool isShowIconError1 = false;
  bool isShowIconError2 = false;
  bool isShowIconError3 = false;
  bool isShowIconError4 = false;
  bool isShowIconError5 = false;
  bool isShowIconError6 = false;
  bool isShowIconError7 = false;

  bool isOverShaft = false;
  bool isOverShaft12 = false;
  bool isOverShaft34 = false;
  bool isOverShaft5 = false;
  bool isOverShaft67 = false;

  void shaft12(String value) {
    double shaft1 = widget.carDriveShaftController[0].text != ''
        ? double.parse(widget.carDriveShaftController[0].text)
        : 0;
    double shaft2 = widget.carDriveShaftController[1].text != ''
        ? double.parse(widget.carDriveShaftController[1].text)
        : 0;

    double result1 = shaft1 + shaft2;
    if (widget.shaft12 < result1) {
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

    double result2 = shaft3 + shaft4;
    if (widget.shaft34 < result2) {
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

  void shaft5(String value) {
    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;

    double result3 = shaft5;
    if (widget.shaft5 < result3) {
      setState(() {
        isShowIconError5 = true;
      });
    } else {
      setState(() {
        isShowIconError5 = false;
      });
    }

    calOverShaft();
  }

  void shaft67(String value) {
    double shaft6 = widget.carDriveShaftController[5].text != ''
        ? double.parse(widget.carDriveShaftController[5].text)
        : 0;
    double shaft7 = widget.carDriveShaftController[6].text != ''
        ? double.parse(widget.carDriveShaftController[6].text)
        : 0;

    double result4 = shaft6 + shaft7;
    if (widget.shaft67 < result4) {
      setState(() {
        isShowIconError6 = true;
        isShowIconError7 = true;
      });
    } else {
      setState(() {
        isShowIconError6 = false;
        isShowIconError7 = false;
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

    double result1 = shaft1 + shaft2;
    if (widget.shaft12 < result1) {
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

    double result2 = shaft3 + shaft4;
    if (widget.shaft34 < result2) {
      setState(() {
        isOverShaft34 = true;
      });
    } else {
      setState(() {
        isOverShaft34 = false;
      });
    }

    double shaft5 = widget.carDriveShaftController[4].text != ''
        ? double.parse(widget.carDriveShaftController[4].text)
        : 0;

    double result3 = shaft5;
    if (widget.shaft5 < result3) {
      setState(() {
        isOverShaft5 = true;
      });
    } else {
      setState(() {
        isOverShaft5 = false;
      });
    }

    double shaft6 = widget.carDriveShaftController[5].text != ''
        ? double.parse(widget.carDriveShaftController[5].text)
        : 0;
    double shaft7 = widget.carDriveShaftController[6].text != ''
        ? double.parse(widget.carDriveShaftController[6].text)
        : 0;

    double result4 = shaft6 + shaft7;
    if (widget.shaft67 < result4) {
      setState(() {
        isOverShaft67 = true;
      });
    } else {
      setState(() {
        isOverShaft67 = false;
      });
    }

    if (isOverShaft12 == true &&
        isOverShaft34 == true &&
        isOverShaft5 == true &&
        isOverShaft67 == true) {
      isOverShaft = false;
    } else {
      if (isOverShaft12 || isOverShaft34 || isOverShaft5 || isOverShaft67) {
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
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft67(value);
                  }
                  widget.onTextChange!(value, 'ds_6', isOverShaft);
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
                title: 'น้ำหนักเพลาที่ 7',
                isRequired: true,
              ),
              ShaftTextFieldWidget(
                hint: widget.hint,
                controller: widget.carDriveShaftController[6],
                focusNode: widget.carDriveShaftFocusNode[6],
                isShowIconError: isShowIconError7,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    shaft67(value);
                  }
                  widget.onTextChange!(value, 'ds_7', isOverShaft);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
