import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

class HtmlFullcontentWidget extends StatefulWidget {
  const HtmlFullcontentWidget({
    super.key,
    required this.item,
  });

  final String item;

  @override
  State<HtmlFullcontentWidget> createState() => _HtmlFullcontentWidgetState();
}

class _HtmlFullcontentWidgetState extends State<HtmlFullcontentWidget> {
  bool _isExpanded = true;
  final double _collapsedHeight = 30.0; // Adjust this as needed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: _isExpanded ? double.infinity : _collapsedHeight,
          ),
          child: SingleChildScrollView(
              physics: _isExpanded ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
              child: HtmlWidget(
                widget.item,
                textStyle: const TextStyle(
                  color: ColorApps.colorGray, // เปลี่ยนสีตัวอักษรที่คุณต้องการ
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ),
      ],
    );
  }
}
