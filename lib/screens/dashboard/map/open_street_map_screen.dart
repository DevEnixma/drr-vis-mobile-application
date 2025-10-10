import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../data/models/road_code_car/road_code_car_req.dart';
import '../../../data/models/road_code_detail/road_code_detail_model.dart';
import '../../../service/token_refresh.service.dart';
import '../../../utils/constants/text_style.dart';
import 'widgets/map_with_route.dart';

class OpenStreetMapScreen extends StatefulWidget {
  final String title;
  const OpenStreetMapScreen({super.key, required this.title});

  @override
  State<OpenStreetMapScreen> createState() => _OpenStreetMapScreenState();
}

class _OpenStreetMapScreenState extends State<OpenStreetMapScreen> {
  final MapController _mapController = MapController();

  int page = 1;
  int pageSize = 8;
  // int pageSize = 2000000;

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() {
    getRoadCodeDetailBloc();
    getRoadCodeCarBloc();
  }

  void getRoadCodeDetailBloc() {
    context.read<DashboardBloc>().add(GetRoadCodeDetailEvent(widget.title));
  }

  void getRoadCodeCarBloc() {
    var payload = RoadCodeCarModelReq(
      page: page,
      pageSize: pageSize,
      order: 'DESC',
      isOnAssignedRoad: 'true',
      roadCodes: widget.title,
    );
    context.read<DashboardBloc>().add(GetRoadCodeCarEvent(payload));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.surface,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'ปริมาณรถในสายทาง ${widget.title}',
            textAlign: TextAlign.center,
            style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
          )),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.roadCodeDetailStatus == RoadCodeDetailStatus.loading) {}
          if (state.roadCodeDetailStatus == RoadCodeDetailStatus.success && state.roadCodeDetail != null) {
            RoadCodeDetailModel item = state.roadCodeDetail!;
            // PositionMiddleModel positionMiddle = state.positionMiddle!;

            return MapWithRoute(
              item: item,
              title: widget.title,
            );
          }
          if (state.roadCodeDetailStatus == RoadCodeDetailStatus.error) {}

          return SizedBox.shrink();
        },
      ),
    );
  }
}
