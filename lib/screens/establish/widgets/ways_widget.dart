import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/blocs/ways/ways_bloc.dart';

import '../../../data/models/master_data/ways/ways_res.dart';
import '../../../utils/constants/text_style.dart';

class WaysWidget extends StatefulWidget {
  const WaysWidget({
    super.key,
    required this.item,
  });

  final WaysRes item;

  @override
  State<WaysWidget> createState() => _WaysWidgetState();
}

class _WaysWidgetState extends State<WaysWidget> {
  void seletedWay(WaysRes value) {
    context.read<WaysBloc>().add(SelectedWay(value));
    context.read<WaysBloc>().add(GetWayDetail(value.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        seletedWay(widget.item);
        // widget.onClose(item);
        Navigator.pop(context);
      },
      leading: SvgPicture.asset(
        'assets/svg/coordinates_icon.svg',
        // width: 20.h,
      ),
      title: Text(
        widget.item.wayCode ?? '',
        style: AppTextStyle.title16normal(),
      ),
      // subtitle: Text(subtitle),
    );
  }
}
