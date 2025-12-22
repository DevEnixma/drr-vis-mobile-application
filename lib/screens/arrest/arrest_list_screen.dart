import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes.dart';
import '../../app/routes/routes_constant.dart';
import '../../blocs/establish/establish_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data/models/establish/mobile_master_model.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/libs/convert_date.dart';
import '../../utils/libs/string_helper.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/sneckbar_message.dart';
import '../widgets/empty_widget.dart';

class ArrestListScreen extends StatefulWidget {
  const ArrestListScreen({super.key});

  @override
  State<ArrestListScreen> createState() => _ArrestListScreenState();
}

class _ArrestListScreenState extends State<ArrestListScreen> {
  static const int _pageSize = 20;

  final LocalStorage _storage = LocalStorage();
  late final ScrollController _scrollController;
  final FocusNode _focusNode = FocusNode();

  String? _accessToken;
  String _search = '';
  int _currentPage = 1;
  List<MobileMasterModel> _weightUnits = [];

  late final DateTime _startDate;
  late final DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _setupScrollController();
    _initScreen();
  }

  void _initializeDates() {
    final now = DateTime.now();
    _startDate = ConvertDate.dateTimeYearSubstract(now, 1);
    _endDate = ConvertDate.dateTimeYearAdd(now, 1);
  }

  void _setupScrollController() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  Future<void> _initScreen() async {
    final token = await _storage.getValueString(KeyLocalStorage.accessToken);
    if (context.read<ProfileBloc>().state.profile != null && token != null) {
      setState(() {
        _accessToken = token;
      });
    } else {
      setState(() {
        _accessToken = null;
      });
    }

    _getMobileMasterList();
  }

  void _getMobileMasterList() {
    context.read<EstablishBloc>().add(
          MobileMasterFetchEvent(
            start_date: ConvertDate.convertDateToYYYYDDMM(_startDate),
            end_date: ConvertDate.convertDateToYYYYDDMM(_endDate),
            page: _currentPage,
            pageSize: _pageSize,
          ),
        );
  }

  void _loadMore() {
    setState(() {
      _currentPage++;
    });
    _getMobileMasterList();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _currentPage = 1;
    });
    _getMobileMasterList();
  }

  void _onChangedText(String value) {
    setState(() {
      _search = value;
      _currentPage = 1;
    });
  }

  List<MobileMasterModel> _filterList(List<MobileMasterModel> list) {
    // กรองเฉพาะหน่วยที่มีรถน้ำหนักเกิน (การจับกุม)
    var filteredByArrest = list.where((item) {
      final totalOver = int.tryParse(item.totalOver ?? '0') ?? 0;
      return totalOver > 0;
    }).toList();

    // ถ้าไม่มีการค้นหา ให้คืนรายการที่มีการจับกุม
    if (_search.isEmpty) return filteredByArrest;

    // ถ้ามีการค้นหา ให้กรองต่อจากชื่อและสถานที่
    return filteredByArrest.where((item) {
      final searchLower = _search.toLowerCase();
      final wayID = item.wayID?.toLowerCase() ?? '';
      final wayName = item.wayName?.toLowerCase() ?? '';
      final district = item.district?.toLowerCase() ?? '';
      final province = item.province?.toLowerCase() ?? '';
      final collaboration = item.collaboration?.toLowerCase() ?? '';

      return wayID.contains(searchLower) ||
          wayName.contains(searchLower) ||
          district.contains(searchLower) ||
          province.contains(searchLower) ||
          collaboration.contains(searchLower);
    }).toList();
  }

  void _goToArrestDetail(MobileMasterModel item) async {
    await _storage.setValueString(KeyLocalStorage.weightUnitId, item.tID ?? '');

    if (mounted) {
      Routes.gotoArrestScreen(context: context);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'การจับกุม',
          style: AppTextStyle.title18bold(
              color: Theme.of(context).colorScheme.surface),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _accessToken != null && _accessToken != ''
                  ? Routes.gotoProfile(context)
                  : Navigator.pushNamed(context, RoutesName.loginScreen);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  _accessToken != null && _accessToken != ''
                      ? 'assets/svg/ph_sign-out-bold.svg'
                      : 'assets/svg/iconamoon_profile-fill.svg',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
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
                            focusNode: _focusNode,
                            onChanged: _onChangedText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ค้นหาสายทาง',
                              hintStyle: AppTextStyle.title16normal(
                                  color: ColorApps.colorGray),
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
                  BlocBuilder<EstablishBloc, EstablishState>(
                    builder: (context, state) {
                      if (state.establishMobileMasterStatus ==
                          EstablishMobileMasterStatus.success) {
                        final weightUnits = state.mobile_master_list ?? [];
                        final filtered = _filterList(weightUnits);
                        return Text(
                          '${StringHleper.numberAddComma(filtered.length.toString())} รายการ',
                          style: AppTextStyle.title16bold(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 12,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<EstablishBloc, EstablishState>(
                builder: (context, state) {
                  if (state.establishMobileMasterStatus ==
                      EstablishMobileMasterStatus.loading) {
                    return const Center(child: CustomLoadingPagination());
                  }

                  if (state.establishMobileMasterStatus ==
                      EstablishMobileMasterStatus.success) {
                    final weightUnits = state.mobile_master_list ?? [];
                    final filtered = _filterList(weightUnits);

                    if (filtered.isEmpty) {
                      return EmptyWidget(
                        title: _search.isEmpty
                            ? 'ไม่พบรายการการจับกุม'
                            : 'ไม่พบผลการค้นหา',
                        label: _search.isEmpty
                            ? 'ยังไม่มีรถที่น้ำหนักเกินในหน่วยต่างๆ'
                            : 'ลองค้นหาด้วยคำอื่น',
                      );
                    }

                    _weightUnits = filtered;

                    return RefreshIndicator(
                      onRefresh: _refreshData,
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => Divider(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          height: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        itemCount: _weightUnits.length,
                        itemBuilder: (context, index) {
                          final item = _weightUnits[index];
                          return ArrestItemWidget(
                            item: item,
                            onTap: () => _goToArrestDetail(item),
                          );
                        },
                      ),
                    );
                  }

                  if (state.establishMobileMasterStatus ==
                          EstablishMobileMasterStatus.error &&
                      state.establishMobileMasterError != null) {
                    showSnackbarBottom(
                        context, state.establishMobileMasterError!);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<EstablishBloc, EstablishState>(
              builder: (context, state) {
                if (state.isLoadMore == true) {
                  return const Center(child: CustomLoadingPagination());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ArrestItemWidget extends StatelessWidget {
  final MobileMasterModel item;
  final VoidCallback onTap;

  const ArrestItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ชื่อหน่วย + รถน้ำหนักเกิน
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'สายทาง ${item.wayID ?? ''}',
                    style: AppTextStyle.title16bold(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 6.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'รถน้ำหนักเกิน ${StringHleper.numberAddComma(item.totalOver.toString())} คัน',
                          style: AppTextStyle.title14bold(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // รูปภาพ + สถานที่
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // รูปภาพ
                Container(
                  height: 69.h,
                  width: 69.h,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      item.imagePath1 ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/app_logo.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),

                // สถานที่
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/tabler_map-pin.svg',
                          width: 20.h,
                        ),
                        SizedBox(width: 5.h),
                        Text(
                          'ที่อยู่ที่จัดตั้ง',
                          style: AppTextStyle.title16normal(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 220.w,
                          child: Text(
                            '${item.wayName ?? ''} ${item.subdistrict ?? ''} ${item.district ?? ''} ${item.province ?? ''}',
                            style: AppTextStyle.title16normal(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
