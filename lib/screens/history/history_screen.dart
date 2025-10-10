import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/utils/libs/convert_date.dart';
import 'package:wts_bloc/utils/libs/string_helper.dart';

import '../../app/routes/routes.dart';
import '../../app/routes/routes_constant.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/sneckbar_message.dart';
import 'widgets/item_list_widget.dart';

class HistoryScreen extends StatefulWidget {
  final String title;
  const HistoryScreen({super.key, required this.title});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final LocalStorage storage = LocalStorage();

  late ScrollController scrollController;

  String? accessToken;

  final FocusNode focusNode = FocusNode();

  int page = 1;
  int pageSize = 20;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String search = '';

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    initScreen();
  }

  void initScreen() async {
    String? token = await storage.getValueString(KeyLocalStorage.accessToken);
    if (context.read<ProfileBloc>().state.profile != null && token != null) {
      setState(() {
        accessToken = token;
      });
    } else {
      setState(() {
        accessToken = null;
      });
    }

    getWeightUnits();
  }

  void getWeightUnits() {
    context.read<WeightUnitBloc>().add(
          GetWeightUnitsEvent(
            start_date: ConvertDate.convertDateToYYYYDDMM(ConvertDate.dateTimeSubstract(startDate, 7)),
            end_date: ConvertDate.convertDateToYYYYDDMM(ConvertDate.dateTimeSubstract(endDate, 1)),
            page: page,
            pageSize: pageSize,
            search: search,
            branch: '',
          ),
        );
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
      getWeightUnits();
    });
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
    });
    getWeightUnits();
  }

  void onChangedText(String value) {
    setState(() {
      search = value;
      page = 1;
    });
    getWeightUnits();
  }

  void unfocusTextField() {
    if (focusNode.hasFocus) {
      focusNode.unfocus(); // ยกเลิกการโฟกัส TextField
    }
  }

  @override
  void dispose() {
    scrollController.dispose();

    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          widget.title,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              accessToken != null && accessToken != '' ? Routes.gotoProfile(context) : Navigator.pushNamed(context, RoutesName.loginScreen);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  accessToken != null && accessToken != '' ? 'assets/svg/ph_sign-out-bold.svg' : 'assets/svg/iconamoon_profile-fill.svg',
                  color: Theme.of(context).colorScheme.surface,
                  width: 22.h,
                ),
                SizedBox(width: 15.h),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 18.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ri_search-line.svg',
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            onChanged: onChangedText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ค้นหาสายทาง',
                              hintStyle: AppTextStyle.title16normal(color: ColorApps.colorGray),
                              border: InputBorder.none,
                            ),
                            style: AppTextStyle.title16normal(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('รายการทั้งหมด', style: AppTextStyle.title16bold()),
                  Text('${StringHleper.convertFormatYearTh(ConvertDate.dateTimeSubstract(startDate, 7), 'dd MMMM')} - ${StringHleper.convertFormatYearTh(ConvertDate.dateTimeSubstract(startDate, 1), 'dd MMMM yyyy')}', style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.onTertiary, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<WeightUnitBloc, WeightUnitState>(
                builder: (context, state) {
                  if (state.weightUnitsStatus == WeightUnitStatus.loading) {
                    return const Center(child: CustomLoadingPagination());
                  }
                  if (state.weightUnitsStatus == WeightUnitStatus.success) {
                    if (state.weightUnits!.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: refreshData,
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: ListView.separated(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => Divider(
                            color: Theme.of(context).colorScheme.tertiaryContainer, // You can change the color or thickness of the divider here
                            height: 1, // Height between items
                            indent: 20,
                            endIndent: 20,
                          ),
                          itemCount: state.weightUnits!.length, // Number of items in the list
                          itemBuilder: (context, index) {
                            return ItemListWidget(
                              item: state.weightUnits![index],
                            );
                          },
                        ),
                      );
                    }
                  }

                  if (state.weightUnitsStatus == WeightUnitStatus.error && state.weightUnitsError != '') {
                    showSnackbarBottom(context, state.weightUnitsError!);
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<WeightUnitBloc, WeightUnitState>(builder: (context, state) {
              if (state.weightUnitsLoadmore == true) {
                return const Center(child: CustomLoadingPagination());
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
