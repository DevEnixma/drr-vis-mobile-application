import 'package:flutter/services.dart';

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String part1 = '';
    String part2 = '';

    if (newText.length > 0) {
      part1 = newText.substring(0, newText.length.clamp(0, 2));
    }

    if (newText.length > 2) {
      part2 = newText.substring(2, newText.length.clamp(2, 6));
    }

    String formattedText = part1;
    if (part2.isNotEmpty) {
      formattedText += ' + $part2';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
