import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/blocs/news/news_bloc.dart';
import 'package:wts_bloc/data/models/news/news_model_req.dart';

import '../../app/routes/routes.dart';
import '../../app/routes/routes_constant.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/sneckbar_message.dart';
import 'widgets/news_item_widget.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  const InformationScreen({super.key, required this.title});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final LocalStorage storage = LocalStorage();

  late ScrollController scrollController;

  String? accessToken;

  String searchNews = '';
  int page = 1;
  int pageSize = 20;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    initScreen();
  }

  void initScreen() async {
    String? token = await storage.getValueString(KeyLocalStorage.accessToken);

    // ⭐ เปลี่ยนจากการเช็ค profile เป็นเช็ค token อย่างเดียว
    setState(() {
      accessToken = token;
    });

    getNewsesBloc();
  }

  void getNewsesBloc() {
    var payload = NewsModelReq(
      search: searchNews,
      page: page,
      pageSize: pageSize,
    );
    context.read<NewsBloc>().add(GetNewses(payload));
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
      getNewsesBloc();
    });
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
    });
    getNewsesBloc();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onChangedText(String value) {
    setState(() {
      searchNews = value;
      page = 1;
    });
    getNewsesBloc();
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
          widget.title,
          style: AppTextStyle.title18bold(
              color: Theme.of(context).colorScheme.surface),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              accessToken != null && accessToken != ''
                  ? Routes.gotoProfile(context)
                  : Navigator.pushNamed(context, RoutesName.loginScreen);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  accessToken != null && accessToken != ''
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
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged: onChangedText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'ค้นหาข่าวสาร',
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
                  Text('ข่าวสารทั้งหมด', style: AppTextStyle.title16bold()),
                  BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      return Text('${state.newsTotal} รายการ',
                          style: AppTextStyle.title16bold(
                              color: Theme.of(context).colorScheme.onTertiary));
                    },
                  ),
                ],
              ),
            ),
            BlocListener<NewsBloc, NewsState>(
              listenWhen: (previous, current) =>
                  previous.newsesStatus != current.newsesStatus,
              listener: (context, state) {
                if (state.newsesStatus == NewsStatus.error &&
                    state.newsesError != null &&
                    state.newsesError!.isNotEmpty) {
                  showSnackbarBottom(context, state.newsesError!);
                }
              },
              child: const SizedBox.shrink(),
            ),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state.newsesStatus == NewsStatus.loading) {
                    return const Center(child: CustomLoadingPagination());
                  }
                  if (state.newsesStatus == NewsStatus.success) {
                    // กรณีไม่มีข่าวสารเลย
                    if (state.newsTotal == 0) {
                      return RefreshIndicator(
                        onRefresh: refreshData,
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.announcement_outlined,
                                    size: 80.h,
                                    color: ColorApps.colorGray,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    searchNews.isEmpty
                                        ? 'ไม่มีข่าวสาร'
                                        : 'ไม่พบข่าวสารที่ค้นหา',
                                    style: AppTextStyle.title18bold(
                                      color: ColorApps.colorGray,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    searchNews.isEmpty
                                        ? 'ยังไม่มีข่าวสารในขณะนี้'
                                        : 'ลองค้นหาด้วยคำอื่น',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.title14normal(
                                      color: ColorApps.colorGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // กรณีมีข่าวสาร
                    if (state.newses != null && state.newses!.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: refreshData,
                        color: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: ListView.separated(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => Divider(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            height: 0,
                            indent: 20,
                            endIndent: 20,
                          ),
                          itemCount: state.newses!.length,
                          itemBuilder: (context, index) {
                            return NewsItemWidget(
                              item: state.newses![index],
                            );
                          },
                        ),
                      );
                    }
                  }
                  if (state.newsesStatus == NewsStatus.error) {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
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
                                    state.newsesError ?? 'Unknown error',
                                    style: AppTextStyle.title14normal(
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        page = 1;
                                      });
                                      getNewsesBloc();
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
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state.newsesLoadMore == true) {
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
