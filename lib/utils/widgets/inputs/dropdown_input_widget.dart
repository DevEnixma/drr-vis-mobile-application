import 'package:flutter/material.dart';

import '../../constants/color_app.dart';
import '../../constants/text_style.dart';

class DropdownInputWidget extends StatefulWidget {
  final String label;
  final String hint;
  final String? value;
  final FocusNode focusNode;
  final ValueChanged<String?> onChanged;

  DropdownInputWidget({
    required this.label,
    required this.hint,
    this.value,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  State<DropdownInputWidget> createState() => _DropdownInputWidgetState();
}

class _DropdownInputWidgetState extends State<DropdownInputWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
      ),
      items: <String>['Option 1', 'Option 2', 'Option 3'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: widget.value,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          widget.focusNode.requestFocus(); // Focus กลับไปที่ Text Input
          return "กรุณาเลือกข้อมูล";
        }
        return null;
      },
    );
  }
}
