import 'package:flutter/material.dart';
import 'package:wts_bloc/utils/libs/string_helper.dart';

import '../../../../data/models/road_code_car/road_code_car_model_res.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';
import 'map_car_icon_widget.dart';

class MapCarItemWidget extends StatefulWidget {
  const MapCarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final RoadCodeCarModelRes item;
  final Function(RoadCodeCarModelRes) isSelected;

  @override
  State<MapCarItemWidget> createState() => _MapCarItemWidgetState();
}

class _MapCarItemWidgetState extends State<MapCarItemWidget> {
  @override
  Widget build(BuildContext context) {
    RoadCodeCarModelRes item = widget.item;
    return ListTile(
      onTap: () {
        widget.isSelected(item);
      },
      leading: MapCarIconWidget(
        keyIcon: item,
      ),
      title: Text(
        StringHleper.checkString(item.plate),
        style: AppTextStyle.title16bold(fontSize: 16, color: ColorApps.colorText),
      ),
      subtitle: Text(
        StringHleper.checkString(item.wheelDesc),
        style: AppTextStyle.label12normal(fontSize: 16, color: ColorApps.colorText),
      ),
    );
  }
}
