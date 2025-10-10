import 'package:flutter/material.dart';

import '../../../../data/models/road_code_car/road_code_car_model_res.dart';
import '../../../../utils/constants/text_style.dart';

class PopUpWidgget extends StatelessWidget {
  const PopUpWidgget({
    super.key,
    required this.item,
  });

  final RoadCodeCarModelRes item;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 180.h,
      left: 60.h,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ทะเบียน 70-0986 - ร้อยเอ็ด',
                style: AppTextStyle.title16boldUnderLine(),
              ),
              Text(
                'รถพ่วง (ยาง 8 ล้อ)',
                style: AppTextStyle.title16bold(),
              ),
              SizedBox(height: 4),
              Divider(
                color: Theme.of(context).colorScheme.tertiaryContainer, // You can change the color or thickness of the divider here
                height: 2, // Height between items
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  text: 'กม.ที่',
                  style: AppTextStyle.title16normal(),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' 17 ',
                      style: AppTextStyle.title16bold(),
                    ),
                    TextSpan(
                      text: ' ความเร็วที่',
                      style: AppTextStyle.title16normal(),
                    ),
                    TextSpan(
                      text: ' 48 ',
                      style: AppTextStyle.title16bold(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on int {
  get h => null;
}
