import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../data/models/establish/mobile_master_department_model.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../arrest/arrest_screen.dart';
import '../widgets/empty_widget.dart';

class WeightUnitListScreen extends StatefulWidget {
  const WeightUnitListScreen({super.key});

  @override
  State<WeightUnitListScreen> createState() => _WeightUnitListScreenState();
}

class _WeightUnitListScreenState extends State<WeightUnitListScreen> {
  final LocalStorage storage = LocalStorage();
  final ScrollController _scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  int page = 1;
  int pageSize = 20;
  String search = '';
  bool isLoadmore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getWeightUnitList();
  }

  void getWeightUnitList() {
    context
        .read<WeightUnitBloc>()
        .add(GetMasterDepartments(page: page, pageSize: pageSize));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      loadMore();
    }
  }

  void loadMore() async {
    final state = context.read<WeightUnitBloc>().state;
    if (state.masterDepartmentsStatus == MasterDepartmentsStatus.success &&
        state.masterDepartments != null &&
        state.masterDepartments!.length < state.masterDepartmentsTotal) {
      setState(() {
        page = page + 1;
        isLoadmore = true;
      });
      getWeightUnitList();
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
    });
    getWeightUnitList();
  }

  void onChangedText(String value) {
    setState(() {
      search = value;
      page = 1;
    });
    getWeightUnitList();
  }

  void onTapWeightUnit(MobileMasterDepartmentModel item) async {
    // Save selected weight unit ID to local storage
    await storage.setValueString(KeyLocalStorage.weightUnitId, item.tid ?? '');

    // Navigate to ArrestScreen
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArrestScreen(title: item.name ?? 'การจับกุม'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text('หน่วยตั้งตรวจชั่งน้ำหนัก',
              style: AppTextStyle.title18bold()),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('รายการหน่วยตั้ง',
                              style: AppTextStyle.title16bold()),
                          BlocBuilder<WeightUnitBloc, WeightUnitState>(
                            builder: (context, state) {
                              if (state.masterDepartmentsStatus ==
                                  MasterDepartmentsStatus.success) {
                                return Text(
                                    '${state.masterDepartmentsTotal} รายการ',
                                    style: AppTextStyle.title16bold(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary));
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 4.h),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/ri_search-line.svg',
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextField(
                                focusNode: focusNode,
                                onChanged: onChangedText,
                                style: AppTextStyle.title18normal(),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'ค้นหาชื่อหน่วยตั้ง',
                                  hintStyle: AppTextStyle.title16normal(
                                      color: ColorApps.colorGray),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<WeightUnitBloc, WeightUnitState>(
                builder: (context, state) {
                  if (state.masterDepartmentsStatus ==
                          MasterDepartmentsStatus.loading &&
                      page == 1) {
                    return SliverFillRemaining(
                      child: Center(
                        child: SkeletionContainerWidget(
                          height: 80.h,
                          width: 300.w,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    );
                  }

                  if (state.masterDepartmentsStatus ==
                      MasterDepartmentsStatus.success) {
                    setState(() {
                      isLoadmore = false;
                    });

                    if (state.masterDepartments == null ||
                        state.masterDepartments!.isEmpty) {
                      return SliverFillRemaining(
                        child: EmptyWidget(
                          title: 'ไม่พบรายการหน่วยตั้ง',
                          label: 'กรุณาเพิ่มหน่วยตั้งใหม่',
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final unit = state.masterDepartments![index];
                          return WeightUnitItemWidget(
                            item: unit,
                            onTap: () => onTapWeightUnit(unit),
                          );
                        },
                        childCount: state.masterDepartments?.length ?? 0,
                      ),
                    );
                  }

                  return const SliverFillRemaining(
                    child: SizedBox.shrink(),
                  );
                },
              ),
              if (isLoadmore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CustomLoadingPagination()),
                  ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(height: 20.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeightUnitItemWidget extends StatelessWidget {
  final MobileMasterDepartmentModel item;
  final VoidCallback onTap;

  const WeightUnitItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name ?? 'ไม่ระบุชื่อ',
                        style: AppTextStyle.title16bold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.address != null && item.address!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            item.address!,
                            style: AppTextStyle.title14normal(
                                color: ColorApps.colorGray),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorApps.colorGray,
                  size: 18.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
