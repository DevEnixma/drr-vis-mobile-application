import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../../data/models/road_code_car/road_code_car_model_res.dart';
import '../../../../data/models/road_code_detail/road_code_detail_model.dart';
import '../../../../main.dart';
import '../../../../service/token_refresh.service.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/string_helper.dart';
import 'custom_map_bottom_sheet.dart';

class MapWithRoute extends StatefulWidget {
  const MapWithRoute({
    super.key,
    required this.item,
    required this.title,
  });

  final String title;
  final RoadCodeDetailModel item;

  @override
  State<MapWithRoute> createState() => _MapWithRouteState();
}

class _MapWithRouteState extends State<MapWithRoute> {
  List<LatLng> routePoints = [];
  LatLng startPoint = LatLng(13.02358, 101.06972); // พิกัดเริ่มต้น (Bangkok)
  LatLng endPoint = LatLng(13.06101, 100.96548); // พิกัดสิ้นสุด (บางนา)

  LatLng? selectedMarker;
  final MapController _mapController = MapController();
  RoadCodeCarModelRes carDetail = RoadCodeCarModelRes.empty();

  double initialChildSize = 0.3;
  double mixSize = 0.3;

  List<RoadCodeCarModelRes> itamsCar = [];

  @override
  void initState() {
    super.initState();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    RoadCodeDetailModel item = widget.item;

    setState(() {
      startPoint = LatLng(item.latStart!, item.lonStart!); // พิกัดเริ่มต้น (Bangkok)
      endPoint = LatLng(item.latEnd!, item.lonEnd!); // พิกัดสิ้นสุด (บางนา)
    });

    final url = "http://router.project-osrm.org/route/v1/driving/${startPoint.longitude},${startPoint.latitude};${endPoint.longitude},${endPoint.latitude}?geometries=geojson";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final geometry = data['routes'][0]['geometry']['coordinates'] as List;
      final points = geometry.map((point) {
        return LatLng(point[1], point[0]);
      }).toList();

      setState(() {
        routePoints = points;
      });
    } else {
      logger.e('Error fetching route: ${response.statusCode}');
    }
  }

  void isOpenPopUp(RoadCodeCarModelRes item) {
    setState(() {
      carDetail = item;
      selectedMarker = LatLng(item.geom.coordinates[1], item.geom.coordinates[0]);
      _mapController.move(LatLng(item.geom.coordinates[1], item.geom.coordinates[0]), 14.0);
    });

    DraggableScrollableActuator.reset(context);
  }

  void isClosePopUp() {
    setState(() {
      selectedMarker = null;
      carDetail = RoadCodeCarModelRes.empty();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: startPoint,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                isClosePopUp();
              },
              // onPositionChanged: (camera, hasGesture) {
              //   if (selectedMarker != null) {
              //     isClosePopUp();
              //   }
              // },
            ),
            children: [
              // TileLayer(
              //   // urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              //   // subdomains: ['a', 'b', 'c'],
              //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              // ),
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: startPoint,
                    child: Icon(
                      Icons.circle, // ใช้ไอคอนตำแหน่ง
                      color: Color(0xffff0000), // กำหนดสีเป็นสีแดง
                      size: 10.0, // ขนาดไอคอน
                    ),
                    width: 40.0, // กำหนดความกว้างของ Marker
                    height: 40.0, // กำหนดความสูงของ Marker
                  ),
                  Marker(
                    point: endPoint,
                    child: Icon(
                      Icons.circle, // ใช้ไอคอนตำแหน่ง
                      color: Color(0xffff0000), // กำหนดสีเป็นสีแดง
                      size: 10.0, // ขนาดไอคอน
                    ),
                    width: 40.0, // กำหนดความกว้างของ Marker
                    height: 40.0, // กำหนดความสูงของ Marker
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: Colors.red,
                    strokeWidth: 2.0,
                  ),
                ],
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state.roadCodeCarStatus == RoadCodeCarStatus.success && state.roadCodeCar!.isNotEmpty) {
                    // สร้าง Marker แบบไดนามิก
                    return MarkerLayer(
                      markers: state.roadCodeCar!.map((markerData) {
                        return Marker(
                          point: LatLng(markerData.geom.coordinates[1], markerData.geom.coordinates[0]),
                          width: 35.h,
                          height: 35.h,
                          child: InkWell(
                            onTap: () {
                              isOpenPopUp(markerData);
                              // setState(() {
                              //   selectedMarker = LatLng(markerData.geom.coordinates[1], markerData.geom.coordinates[0]);
                              // });
                              // _mapController.move(LatLng(markerData.geom.coordinates[1], markerData.geom.coordinates[0]), 13.0);
                            },
                            child: SvgPicture.asset(
                              markerData.hasOverweightHistory
                                  ? 'assets/svg/local_shipping_red.svg'
                                  : markerData.speed <= 0
                                      ? 'assets/svg/local_shipping_yellow.svg'
                                      : 'assets/svg/local_shipping_green.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  // กรณียังโหลดข้อมูลอยู่
                  return MarkerLayer(markers: []);
                },
              ),
            ],
          ),
        ),
        if (selectedMarker != null && carDetail != null)
          Positioned(
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
                      StringHleper.checkString(carDetail.plate),
                      style: AppTextStyle.title16boldUnderLine(),
                    ),
                    Text(
                      StringHleper.checkString(carDetail.wheelDesc),
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
                            text: ' - ',
                            style: AppTextStyle.title16bold(),
                          ),
                          TextSpan(
                            text: ' ความเร็วที่',
                            style: AppTextStyle.title16normal(),
                          ),
                          TextSpan(
                            text: ' ${StringHleper.stringToInt(carDetail.speed).toString()} ',
                            style: AppTextStyle.title16bold(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        DraggableScrollableSheet(
          initialChildSize: 0.4, // ค่าเริ่มต้น (ต้อง >= minChildSize)
          minChildSize: 0.2, // ค่าเล็กที่สุด
          maxChildSize: 0.8, // ค่าใหญ่ที่สุด
          builder: (BuildContext context, ScrollController scrollController) {
            return BlocListener<DashboardBloc, DashboardState>(
              listener: (context, state) {
                if (state.roadCodeCarStatus == RoadCodeCarStatus.success) {
                  if (state.roadCodeCar != null) {}
                  itamsCar = state.roadCodeCar ?? [];
                }
              },
              child: CustomMapBottomSheet(
                scrollController: scrollController,
                items: itamsCar,
                roadCode: widget.title,
                isSelected: isOpenPopUp,
              ),
            );
            // return BlocBuilder<DashboardBloc, DashboardState>(
            //   builder: (context, state) {
            //     if (state.roadCodeCarStatus == RoadCodeCarStatus.loading) {
            //       return const Center(child: CustomLoadingPagination());
            //     }
            //     if (state.roadCodeCarStatus == RoadCodeCarStatus.success) {
            //       if (state.roadCodeCar != null && state.roadCodeCar!.isNotEmpty) {
            //         return CustomMapBottomSheet(
            //           scrollController: scrollController,
            //           items: state.roadCodeCar ?? [],
            //           roadCode: widget.title,
            //           isSelected: isOpenPopUp,
            //         );
            //       } else {
            //         return CustomMapBottomSheet(
            //           scrollController: scrollController,
            //           items: [],
            //           roadCode: widget.title,
            //           isSelected: isOpenPopUp,
            //         );
            //       }
            //     }

            //     return SizedBox.shrink();
            //   },
            // );
          },
        ),
      ],
    );
  }
}
