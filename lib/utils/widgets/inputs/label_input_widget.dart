import 'package:flutter/material.dart';

import '../../constants/text_style.dart';

class LabelInputWidget extends StatefulWidget {
  const LabelInputWidget({
    super.key,
    required this.title,
    this.isRequired,
  });

  final String title;
  final bool? isRequired;

  @override
  State<LabelInputWidget> createState() => _LabelInputWidgetState();
}

class _LabelInputWidgetState extends State<LabelInputWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.title,
        style: AppTextStyle.title16bold(),
        children: <TextSpan>[
          if (widget.isRequired != null)
            TextSpan(
              text: '*',
              style: AppTextStyle.title18normal(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    );
  }
}
