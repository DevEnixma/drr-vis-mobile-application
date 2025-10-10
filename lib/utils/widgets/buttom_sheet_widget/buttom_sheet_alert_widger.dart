import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../constants/text_style.dart';

class ButtomSheetAlertWidger extends StatefulWidget {
  const ButtomSheetAlertWidger({
    super.key,
    this.classesId,
    required this.onTapActions,
    required this.titleIcon,
    required this.titleText,
    required this.descText,
    required this.btnText,
    required this.iconName,
    this.iconRolate = 0,
    required this.colors,
    this.colorsIcon,
    this.iconSize,
    this.warningInfo = false,
    this.myGroup,
  });

  final String? classesId;
  final Function(String) onTapActions;
  final String titleIcon;
  final String titleText;
  final String descText;
  final String btnText;
  final IconData iconName;
  final double iconRolate;
  final Color colors;
  final Color? colorsIcon;
  final double? iconSize;
  final bool? warningInfo;
  final AutoSizeGroup? myGroup;

  @override
  State<ButtomSheetAlertWidger> createState() => _ButtomSheetAlertWidgerState();
}

class _ButtomSheetAlertWidgerState extends State<ButtomSheetAlertWidger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   width: 70,
              //   height: 70,
              //   margin: const EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     // color: widget.colors,
              //     color: widget.colorsIcon != null ? Theme.of(context).colorScheme.onPrimary : widget.colors,
              //     shape: BoxShape.circle,
              //   ),
              //   child: Transform.rotate(
              //     angle: widget.iconRolate,
              //     child: Icon(
              //       widget.iconName,
              //       color: widget.colorsIcon ?? Theme.of(context).colorScheme.onPrimary,
              //       size: widget.iconSize ?? 70,
              //     ),
              //   ),
              // ),
              Container(
                width: 70.w,
                height: 70.h,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset(
                  'assets/images/${widget.titleIcon}.png',
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    AutoSizeText(
                      widget.titleText,
                      style: AppTextStyle.title18bold(fontSize: 22),
                      group: widget.myGroup,
                    ),
                    SizedBox(height: 5.h),
                    AutoSizeText(
                      widget.descText,
                      style: AppTextStyle.title14normal(),
                      textAlign: TextAlign.center,
                      group: widget.myGroup,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApps.colorDary,
                  ),
                  onPressed: () {
                    widget.onTapActions(widget.btnText);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AutoSizeText(
                            textScaleFactor: 1.0,
                            widget.btnText,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.title18bold(color: ColorApps.colorBackground),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}
