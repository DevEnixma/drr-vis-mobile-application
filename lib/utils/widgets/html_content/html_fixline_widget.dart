import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../constants/color_app.dart';

class HtmlFixlineWidget extends StatefulWidget {
  const HtmlFixlineWidget({
    super.key,
    required this.item,
  });

  final String item;

  @override
  State<HtmlFixlineWidget> createState() => _HtmlFixlineWidgetState();
}

class _HtmlFixlineWidgetState extends State<HtmlFixlineWidget> {
  bool _isExpanded = false;
  final double _collapsedHeight = 60.0; // Adjust this as needed

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
            ),
          ),
        ),
        // if (!_isExpanded)
        //   TextButton(
        //     onPressed: () {
        //       setState(() {
        //         _isExpanded = true;
        //       });
        //     },
        //     child: Text(
        //       'read_more'.tr().capitalizeFirstLetter(),
        //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppThemes.colorBlue, decoration: TextDecoration.underline, decorationColor: AppThemes.colorBlue),
        //     ),
        //   ),
        // if (_isExpanded)
        //   TextButton(
        //     onPressed: () {
        //       setState(() {
        //         _isExpanded = false;
        //       });
        //     },
        //     child: Text(
        //       'show_less'.tr().capitalizeFirstLetter(),
        //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppThemes.colorBlue, decoration: TextDecoration.underline, decorationColor: AppThemes.colorBlue),
        //     ),
        //   ),
      ],
    );
  }
}
