import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes.dart';
import '../../app/routes/routes_constant.dart';
import '../../blocs/establish/establish_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data/models/establish/mobile_master_model.dart';
import '../../data/models/home/join_weight_unit.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/libs/convert_date.dart';
import '../../utils/libs/string_helper.dart';
import '../../utils/permission_device/location_device.dart';
import '../../utils/widgets/buttom_sheet_widget/buttom_sheet_alert_widger.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../../utils/widgets/sneckbar_message.dart';
import '../establish/establish_empty_screen.dart';
import '../establish/establish_unit/widget2/item_role_widget.dart';
import 'widgets/card_weight_unit_widget.dart';
import 'widgets/create_weight_unit_widget.dart';

class WeightUnitScreen extends StatefulWidget {
  const WeightUnitScreen({super.key});

  @override
  State<WeightUnitScreen> createState() => _WeightUnitScreenState();
}

class _WeightUnitScreenState extends State<WeightUnitScreen> {
  static const int _pageSize = 20;

  final LocalStorage _storage = LocalStorage();
  late final ScrollController _scrollController;

  String? _accessToken;
  int _currentPage = 1;
  bool _userIsJoin = false;
  bool _isJoinSuccess = false;
  bool _isLeaveJoinSuccess = false;
  String _selectWeightUnitId = '';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeDates() {
    final now = DateTime.now();
    _startDate = ConvertDate.dateTimeYearSubstract(now, 1);
    _endDate = ConvertDate.dateTimeYearAdd(now, 1);
  }

  void _setupScrollController() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _initScreen() async {
    await _loadAccessToken();
    _getWeightUnitsIsJoin();
    _getWeightUnitAll();
  }

  Future<void> _loadAccessToken() async {
    final token = await _storage.getValueString(KeyLocalStorage.accessToken);

    // ⭐ เปลี่ยนจากการเช็ค profile เป็นเช็ค token อย่างเดียว
    setState(() {
      _accessToken = token;
    });
  }

  void _loadMore() {
    setState(() {
      _currentPage++;
    });
    _getWeightUnitAll();
  }

  void _getWeightUnitsIsJoin() {
    context.read<EstablishBloc>().add(
          GetWeightUnitsIsJoinEvent(
            startDate: ConvertDate.convertDateToYYYYDDMM(_startDate),
            endDate: ConvertDate.convertDateToYYYYDDMM(_endDate),
            page: _currentPage,
            pageSize: _pageSize,
          ),
        );
  }

  void _getWeightUnitAll() {
    context.read<EstablishBloc>().add(
          MobileMasterFetchEvent(
            startDate: ConvertDate.convertDateToYYYYDDMM(_startDate),
            endDate: ConvertDate.convertDateToYYYYDDMM(_endDate),
            page: _currentPage,
            pageSize: _pageSize,
          ),
        );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _currentPage = 1;
    });
    _getWeightUnitsIsJoin();
    _getWeightUnitAll();
  }

  Future<void> _addEstablishItem(String value) async {
    final hasPermission =
        await requestLocationPermissionWithDisclosure(context);

    if (hasPermission) {
      if (mounted) {
        Routes.gotoCreateWeightUnit(context);
      }
    } else {
      if (mounted) {
        _showLocationSettingsModal();
      }
    }
  }

  void _showLocationSettingsModal() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ButtomSheetAlertWidger(
        titleText: 'กรุณาเปิดการเข้าถึงตำแหน่ง',
        descText:
            'เพื่ออนุญาตให้ VIS เข้าถึงข้อมูลตำแหน่งของคุณ\nกรุณาไปที่การตั้งค่ามือถือ',
        btnText: 'ไปยังหน้าตั้งค่า',
        iconName: Icons.refresh,
        iconRolate: 90,
        colors: ColorApps.colorDary,
        onTapActions: (_) {
          Navigator.pop(context);
          openAppSettings();
        },
        titleIcon: 'icon_map',
      ),
    );
  }

  void _handleJoinAction(String weightUnitId, bool isJoin) {
    final profile = context.read<ProfileBloc>().state.profile;
    final username = profile?.username;

    if (username == null) {
      showSnackbarBottom(context, 'เกิดข้อผิดพลาด: ไม่พบข้อมูลผู้ใช้');
      return;
    }

    setState(() {
      _selectWeightUnitId = weightUnitId;
    });

    if (isJoin) {
      final payload = JoinWeightUnitReq(
        tId: int.parse(weightUnitId),
        username: username,
      );
      context.read<EstablishBloc>().add(PostJoinWeightUnit(payload, 'main'));
    } else {
      context
          .read<EstablishBloc>()
          .add(DeleteWeightUnitLeaveEvent(weightUnitId, username));
    }
  }

  void _handleLeaveSuccess() {
    _clearUnitId();
    _getWeightUnitsIsJoin();
    _getWeightUnitAll();
    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());

    setState(() {
      _isLeaveJoinSuccess = false;
    });
  }

  void _handleJoinSuccess(String? weightUnitJoinScreen) {
    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
    _getWeightUnitsIsJoin();
    _getWeightUnitAll();

    if (_isJoinSuccess && weightUnitJoinScreen == 'main') {
      Routes.gotoWeightUnitDetailsScreen(context, _selectWeightUnitId);
    }

    setState(() {
      _isJoinSuccess = false;
    });
  }

  Future<void> _clearUnitId() async {
    await _storage.setValueString(KeyLocalStorage.weightUnitId, '');
    setState(() {
      _selectWeightUnitId = '';
    });
  }

  bool get _hasViewerRole {
    return _accessToken != null && _accessToken!.isNotEmpty;
  }

  bool get _shouldShowCreateWidget => _hasViewerRole && !_userIsJoin;

  void _navigateToProfileOrLogin() {
    final isLoggedIn = _accessToken != null && _accessToken!.isNotEmpty;
    if (isLoggedIn) {
      Routes.gotoProfile(context);
    } else {
      Navigator.pushNamed(context, RoutesName.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        if (state.establishMobileMasterStatus ==
                EstablishMobileMasterStatus.loading &&
            _currentPage == 1) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  _buildBackground(),
                  SafeArea(
                    child: Column(
                      children: [
                        _buildHeader(constraints),
                        const Expanded(
                          child: Center(child: CustomLoadingPagination()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                _buildBackground(),
                SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(constraints),
                      _buildBody(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      height: 140.h,
      width: double.infinity,
      child: Image.asset(
        'assets/images/bg_top.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    final shouldAddSpacing =
        constraints.maxWidth <= 400 || constraints.maxWidth >= 600;

    return Column(
      children: [
        if (shouldAddSpacing) SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            _buildProfileButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        SizedBox(width: 15.h),
        SizedBox(
          height: 45.h,
          child: Image.asset('assets/images/logo.png'),
        ),
        SizedBox(width: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ระบบหน่วยชั่งน้ำหนักเคลื่อนที่',
              style: AppTextStyle.title18bold(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            Text(
              'เริ่มปฏิบัติงานตามขั้นตอน',
              style: AppTextStyle.title14normal(
                color: const Color(0xFF56E4EE),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileButton() {
    final isLoggedIn = _accessToken != null && _accessToken!.isNotEmpty;

    return GestureDetector(
      onTap: _navigateToProfileOrLogin,
      child: Row(
        children: [
          SvgPicture.asset(
            isLoggedIn
                ? 'assets/svg/ph_sign-out-bold.svg'
                : 'assets/svg/iconamoon_profile-fill.svg',
            color: Theme.of(context).colorScheme.surface,
            width: 22.h,
          ),
          SizedBox(width: 15.h),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<EstablishBloc, EstablishState>(
          listenWhen: (previous, current) =>
              previous.establishMobileMasterStatus !=
              current.establishMobileMasterStatus,
          listener: (context, state) {
            if (state.establishMobileMasterStatus ==
                    EstablishMobileMasterStatus.error &&
                state.establishMobileMasterError != null &&
                state.establishMobileMasterError!.isNotEmpty) {
              showSnackbarBottom(context, state.establishMobileMasterError!);
            }
          },
        ),
        BlocListener<EstablishBloc, EstablishState>(
          listenWhen: (previous, current) =>
              previous.weightUnitIsJoinStatus != current.weightUnitIsJoinStatus,
          listener: (context, state) {
            if (state.weightUnitIsJoinStatus == WeightUnitIsJoinStatus.error &&
                state.weightUnitIsJoinError != null &&
                state.weightUnitIsJoinError!.isNotEmpty) {
              showSnackbarBottom(context, state.weightUnitIsJoinError!);
            }
          },
        ),
        BlocListener<EstablishBloc, EstablishState>(
          listenWhen: (previous, current) =>
              previous.weightUnitJoinStatus != current.weightUnitJoinStatus ||
              previous.weightUnistLeaveJoinStatus !=
                  current.weightUnistLeaveJoinStatus,
          listener: (context, state) {
            if (state.weightUnitJoinStatus == WeightUnitJoinStatus.error &&
                state.weightUnitJoinError != null &&
                state.weightUnitJoinError!.isNotEmpty) {
              showSnackbarBottom(context, state.weightUnitJoinError!);
            }
            if (state.weightUnistLeaveJoinStatus ==
                    WeightUnistLeaveJoinStatus.error &&
                state.weightUnistLeaveJoinError != null &&
                state.weightUnistLeaveJoinError!.isNotEmpty) {
              showSnackbarBottom(context, state.weightUnistLeaveJoinError!);
            }
          },
        ),
      ],
      child: Expanded(
        child: Column(
          children: [
            _buildLeaveJoinListener(),
            _buildJoinListener(),
            _buildJoinedWeightUnit(),
            _buildEmptyState(),
            _buildWeightUnitsHeader(),
            _buildWeightUnitsList(),
            _buildLoadMoreIndicator(),
            _buildCreateWeightUnitSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveJoinListener() {
    return BlocListener<EstablishBloc, EstablishState>(
      listenWhen: (previous, current) =>
          previous.weightUnistLeaveJoinStatus !=
          current.weightUnistLeaveJoinStatus,
      listener: (context, state) {
        if (state.weightUnistLeaveJoinStatus ==
                WeightUnistLeaveJoinStatus.success &&
            !_isLeaveJoinSuccess) {
          _isLeaveJoinSuccess = true;
          _handleLeaveSuccess();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildJoinListener() {
    return BlocListener<EstablishBloc, EstablishState>(
      listenWhen: (previous, current) =>
          previous.weightUnitJoinStatus != current.weightUnitJoinStatus,
      listener: (context, state) {
        if (state.weightUnitJoinStatus == WeightUnitJoinStatus.success &&
            !_isJoinSuccess) {
          _isJoinSuccess = true;
          _handleJoinSuccess(state.weightUnitJoinScreen);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildJoinedWeightUnit() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        if (state.weightUnitIsJoinStatus != WeightUnitIsJoinStatus.success) {
          return const SizedBox.shrink();
        }

        final joinedUnit = state.weightUnitIsJoin;
        if (joinedUnit?.tID == null) {
          _userIsJoin = false;
          return const SizedBox(height: 80);
        }

        if (_hasViewerRole) {
          _userIsJoin = true;
          return CardWeightUnitWidget(
            item: joinedUnit!,
            isJoinItem: true,
            userIsJoin: _userIsJoin,
            isActionJoin: _handleJoinAction,
          );
        } else {
          _userIsJoin = false;
          return const SizedBox(height: 80);
        }
      },
    );
  }

  Widget _buildEmptyState() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        if (state.establishMobileMasterStatus ==
                EstablishMobileMasterStatus.success &&
            state.establishMobileMasterPagination?.total == 0) {
          return EstablishEmptyScreen();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCreateWeightUnitSection() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        if (_shouldShowCreateWidget &&
            state.establishMobileMasterStatus ==
                EstablishMobileMasterStatus.success &&
            (state.establishMobileMasterPagination?.total ?? 0) > 0) {
          return CreateWeightUnitWidget(addEstablishItem: _addEstablishItem);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWeightUnitsHeader() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        if (state.establishMobileMasterStatus !=
            EstablishMobileMasterStatus.success) {
          return const SizedBox.shrink();
        }

        final total = state.establishMobileMasterPagination?.total ?? 0;
        if (total <= 0) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('หน่วยชั่งที่เปิดอยู่', style: AppTextStyle.title18bold()),
              Text(
                '${StringHleper.numberAddComma(total.toString())} รายการ',
                style: AppTextStyle.title18bold(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeightUnitsList() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        switch (state.establishMobileMasterStatus) {
          case EstablishMobileMasterStatus.success:
            return _buildSuccessState(state);
          case EstablishMobileMasterStatus.error:
            return _buildErrorState(state);
          default:
            return _buildLoadingState();
        }
      },
    );
  }

  Widget _buildSuccessState(EstablishState state) {
    final weightUnits = state.mobileMasterList;

    if (weightUnits != null && weightUnits.isNotEmpty) {
      _weightUnits = weightUnits;
      return _buildWeightUnitsListView();
    } else {
      return _shouldShowCreateWidget
          ? CreateWeightUnitWidget(addEstablishItem: _addEstablishItem)
          : const SizedBox.shrink();
    }
  }

  Widget _buildErrorState(EstablishState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'เกิดข้อผิดพลาด',
                      style: AppTextStyle.title16bold(),
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.establishMobileMasterError ?? 'Unknown error',
                      style: AppTextStyle.title14normal(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentPage = 1;
                        });
                        _getWeightUnitAll();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('ลองอีกครั้ง'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        SkeletionContainerWidget(
          height: 70.h,
          width: 300.w,
          color: Theme.of(context).colorScheme.surface,
        ),
      ],
    );
  }

  Widget _buildWeightUnitsListView() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          children: [
            ListView.builder(
              key: UniqueKey(),
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _weightUnits.length,
              itemBuilder: (context, index) {
                final item = _weightUnits[index];

                return _hasViewerRole
                    ? CardWeightUnitWidget(
                        item: item,
                        isJoinItem: false,
                        userIsJoin: _userIsJoin,
                        isActionJoin: _handleJoinAction,
                      )
                    : ItemRoleWidget(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return BlocBuilder<EstablishBloc, EstablishState>(
      builder: (context, state) {
        return state.isLoadMore == true
            ? const Center(child: CustomLoadingPagination())
            : const SizedBox.shrink();
      },
    );
  }
}
