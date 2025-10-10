import 'package:flutter/material.dart';

import '../../../../data/models/road_code_car/road_code_car_model_res.dart';

class MapCarIconWidget extends StatefulWidget {
  const MapCarIconWidget({
    super.key,
    required this.keyIcon,
  });

  final RoadCodeCarModelRes keyIcon;

  @override
  State<MapCarIconWidget> createState() => _MapCarIconWidgetState();
}

class _MapCarIconWidgetState extends State<MapCarIconWidget> {
  @override
  Widget build(BuildContext context) {
    Widget leadingWidget;

    // switch (widget.keyIcon.hasOverweightHistory) {
    //   case true:
    //     leadingWidget = CircleAvatar(
    //       backgroundColor: Colors.red,
    //       child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
    //     );
    //     break;
    //   case 'not_over':
    //     leadingWidget = CircleAvatar(
    //       backgroundColor: Colors.green,
    //       child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
    //     );
    //     break;
    //   default:
    //     leadingWidget = CircleAvatar(
    //       backgroundColor: Colors.yellow,
    //       child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
    //     );
    // }

    if (widget.keyIcon.hasOverweightHistory) {
      leadingWidget = CircleAvatar(
        backgroundColor: Colors.red,
        child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
      );
    } else {
      if (widget.keyIcon.speed <= 0) {
        leadingWidget = CircleAvatar(
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
        );
      } else {
        leadingWidget = CircleAvatar(
          backgroundColor: Colors.green,
          child: const Icon(Icons.local_shipping_outlined, color: Colors.white),
        );
      }
    }

    return leadingWidget;
  }
}
