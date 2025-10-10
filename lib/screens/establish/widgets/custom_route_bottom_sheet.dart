import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../blocs/ways/ways_bloc.dart';
import '../../../data/models/master_data/ways/ways_req.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/widgets/custom_loading_pagination.dart';
import 'ways_widget.dart';

class CustomRouteBottomSheet extends StatefulWidget {
  const CustomRouteBottomSheet({
    super.key,
    required this.onClose,
    required this.title,
    required this.scrollController,
  });

  final Function(String result) onClose;
  final String title;
  final ScrollController scrollController;

  @override
  State<CustomRouteBottomSheet> createState() => _CustomRouteBottomSheetState();
}

class _CustomRouteBottomSheetState extends State<CustomRouteBottomSheet> {
  TextEditingController waysSearch = TextEditingController();

  int page = 1;
  String order = 'ASC'; // ASC, DESC
  String provinceSearch = '';
  String wayCode = '';

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() async {
    getWaysBloc();
  }

  void getWaysBloc() {
    var payload = WaysReq(
      page: page,
      pageSize: 20,
      order: order,
      wayCode: provinceSearch,
      province: '',
    );
    context.read<WaysBloc>().add(GetWaysEvent(payload));
  }

  void waySearch(String value) {
    setState(() {
      page = 1;
      provinceSearch = value.trim();
    });

    getWaysBloc();
  }

  @override
  void dispose() {
    super.dispose();

    waysSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                widget.title,
                style: AppTextStyle.title16bold(),
              ),
            ],
          ),
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
                SvgPicture.asset(
                  'assets/svg/ri_search-line.svg',

                  // width: 20.h,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหาสายทาง',
                      hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      waySearch(text);
                    },
                    style: AppTextStyle.title16normal(),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<WaysBloc, WaysState>(
              builder: (context, state) {
                if (state.waysStatus == WaysStatus.success) {
                  if (state.ways != null && state.ways!.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context).colorScheme.tertiaryContainer, // You can change the color or thickness of the divider here
                        height: 1, // Height between items
                        indent: 20,
                        endIndent: 20,
                      ),
                      controller: widget.scrollController, // Apply scrollController here
                      itemCount: state.ways!.length, // Number of items in the list
                      itemBuilder: (context, index) {
                        return WaysWidget(
                          item: state.ways![index],
                        );
                      },
                    );
                  }
                }
                return SizedBox.shrink();
              },
            ),
          ),
          BlocBuilder<WaysBloc, WaysState>(builder: (context, state) {
            if (state.isLoadMore == true) {
              return const Center(child: CustomLoadingPagination());
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
