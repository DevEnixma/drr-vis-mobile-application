import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../app/routes/routes_constant.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data/models/profiles/user_profile_res.dart';
import '../../local_storage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/sneckbar_message.dart';
import '../establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorage storage = LocalStorage();

  String positionName(UserProfileRes? profile) {
    String position = '';

    if (profile!.positionName != null) {
      position += profile.positionName ?? '';
    }

    if (profile.deptName != null) {
      position += ', ${profile.deptName}' ?? '';
    }

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // constraints.maxWidth > 400 && constraints.maxWidth < 600  ? 140.h : 120.h;
          return Stack(
            children: [
              SizedBox(
                height: 120.h,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/bg_top.png',
                  fit: BoxFit.fill,
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        constraints.maxWidth > 400 && constraints.maxWidth < 600 ? SizedBox(height: 10.h) : SizedBox(height: 20.h),
                        Text('โปรไฟล์', style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface)),
                        constraints.maxWidth > 400 && constraints.maxWidth < 600 ? SizedBox(height: 10.h) : SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 75.h,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ],
                        ),
                        // body
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state) {
                              if (state.profileStatus == ProfileStatus.success && state.profile != null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${state.profile!.firstName} ${state.profile!.lastName}', style: AppTextStyle.title20bold()),
                                    Text(state.profile!.username ?? '', style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.onTertiary)),
                                    Container(
                                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Theme.of(context).colorScheme.primary)),
                                      margin: EdgeInsets.symmetric(horizontal: 18.h, vertical: 8.h),
                                      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
                                      // child: Text('นายช่างโยธาชำนาญงาน, แขวงทางหลวงชนบทร้อยเอ็ด', style: AppTextStyle.label12bold(color: Theme.of(context).colorScheme.surface)),
                                      child: Text(
                                        positionName(state.profile!),
                                        style: AppTextStyle.label12bold(color: Theme.of(context).colorScheme.surface),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return SizedBox.shrink();
                            },
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 12.h,
                          endIndent: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            _showCustomBottomSheetHelp(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/bx_support.svg',
                                    ),
                                    SizedBox(width: 12.h),
                                    Text('ช่วยเหลือ', style: AppTextStyle.title16bold()),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right_sharp),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                          height: 1,
                          indent: 12.h,
                          endIndent: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            _showCustomBottomSheetSignOut(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/ph_sign-out-bold.svg',
                                    ),
                                    SizedBox(width: 12.h),
                                    Text('ออกจากระบบ', style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.error)),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right_sharp),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 12.h,
                          endIndent: 12.h,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 12.h),
                      child: CustomeButton(
                        text: 'กลับหน้าแรก',
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'itc@drr.go.th',
    );

    final String url = emailLaunchUri.toString();

    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showSnackbarBottom(context, 'Could not send email');
      }
    } else {
      try {
        await launch(url);
      } catch (e) {
        print('===== $e =====');
        showSnackbarBottom(context, 'Could not send email');
      }
    }
  }

  void _showCustomBottomSheetHelp(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.w),
              Text(
                'ติดต่อเจ้าหน้าที่',
                style: AppTextStyle.title18bold(),
              ),
              InkWell(
                onTap: () {
                  launchUrlString("tel://0860847490");
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'โทร :',
                          style: AppTextStyle.title16bold(),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '+662-551-5000',
                            style: AppTextStyle.title14bold(),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.keyboard_arrow_right_sharp),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Color(0xffF2F2F2),
              ),
              InkWell(
                onTap: () {
                  _sendEmail(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'อีเมล :',
                          style: AppTextStyle.title16bold(),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'itc@drr.go.th',
                            style: AppTextStyle.title14bold(),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.keyboard_arrow_right_sharp),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: Text(
              //     'ยกเลิก',
              //     style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomBottomSheetSignOut(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'question_icon_shadow',
          title: 'ยืนยันการออกจากระบบ',
          message: 'ท่านยืนยันที่จะออกจากระบบ ใช่หรือไม่ ?',
          onConfirm: () {
            Navigator.pushReplacementNamed(context, RoutesName.dashboardScreen);
            context.read<ProfileBloc>().add(ClearProfileEvent());
            storage.removeStorageLogout();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
