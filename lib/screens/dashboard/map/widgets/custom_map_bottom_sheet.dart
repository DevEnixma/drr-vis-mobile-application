import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../../data/models/road_code_car/road_code_car_model_res.dart';
import '../../../../data/models/road_code_car/road_code_car_req.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/widgets/custom_loading_pagination.dart';
import 'map_car_item_widget.dart';

class CustomMapBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final List<RoadCodeCarModelRes> items;
  final String roadCode;
  final Function(RoadCodeCarModelRes) isSelected;

  const CustomMapBottomSheet({
    super.key,
    required this.scrollController,
    required this.items,
    required this.roadCode,
    required this.isSelected,
  });

  @override
  State<CustomMapBottomSheet> createState() => _CustomMapBottomSheetState();
}

class _CustomMapBottomSheetState extends State<CustomMapBottomSheet> {
  TextEditingController controllerTextField = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String search = '';
  int page = 1;
  int pageSize = 20;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent) {
        loadMore(); // เรียกฟังก์ชัน loadMore
      }
    });

    initScreen();
  }

  void initScreen() async {}

  void onChangedText(String value) {
    setState(() {
      page = 1;
      search = value;
    });
    getRoadCodeCarBloc();
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
    });
    getRoadCodeCarBloc();
  }

  void getRoadCodeCarBloc() {
    var payload = RoadCodeCarModelReq(
      page: page,
      pageSize: pageSize,
      order: 'DESC',
      isOnAssignedRoad: 'true',
      roadCodes: widget.roadCode,
      search: search,
    );
    context.read<DashboardBloc>().add(GetRoadCodeCarEvent(payload));
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = widget.scrollController;
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiaryFixed,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wraps content height
        children: [
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 10),
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controllerTextField,
                    focusNode: focusNode,
                    onChanged: onChangedText,
                    style: AppTextStyle.title18normal(color: ColorApps.colorText),
                    decoration: InputDecoration(
                      hintText: 'ค้นหาทะเบียนรถบรรทุก',
                      hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 16, bottom: 6),
            child: Text(
              'รายการรถ',
              style: AppTextStyle.title16bold(fontSize: 16, color: ColorApps.colorGray),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController, // Apply scrollController here
              itemCount: widget.items.length, // Number of items in the list
              itemBuilder: (context, index) {
                return MapCarItemWidget(
                  item: widget.items[index],
                  isSelected: widget.isSelected,
                );
              },
            ),
          ),
          // const Center(child: CustomLoadingPagination()),
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
            if (state.roadCodeCarLoadMore == true) {
              return const Center(child: CustomLoadingPagination());
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
