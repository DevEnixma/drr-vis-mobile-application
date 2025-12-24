import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/blocs/profile/profile_bloc.dart';

import '../../app/routes/routes_constant.dart';
import '../../blocs/login/login_bloc.dart';
import '../../data/models/login/login_req.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_loading.dart';
import '../../utils/widgets/sneckbar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Timer? timer;

  bool isVisibility = true;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกข้อมูล';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกข้อมูล';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    initScreen();
  }

  void initScreen() {
    if (!kReleaseMode) {
      usernameController.text = 'kritsada_p';
      passwordController.text = 'DRRP@ssw0rd';
    }
  }

  void postLogin(LoginModelReq loginBody) {
    context.read<LoginBloc>().add(PostLoginEvent(loginBody));
  }

  void loginSuccessGotoDashboardScreen() async {
    getProfile();
    await Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.dashboardScreen,
      (Route<dynamic> route) => false,
    );
  }

  void getProfile() async {
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      // ✅ เพิ่ม listenWhen เพื่อป้องกัน listener ทำงานซ้ำ
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus,
      listener: (context, state) {
        // ✅ Loading state - แสดง loading dialog
        if (state.loginStatus == LoginStatus.loading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomLoading.showLoadingDialog(
                context, Theme.of(context).colorScheme.primary);
          });
        }

        // ✅ Success state - ไป dashboard
        if (state.loginStatus == LoginStatus.success) {
          // ปิด loading dialog จะถูกปิดอัตโนมัติเมื่อ navigate
          loginSuccessGotoDashboardScreen();
        }

        // ✅ Error state - ปิด loading และแสดง error
        if (state.loginStatus == LoginStatus.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomLoading.dismissLoadingDialog(context);
            // แสดง Snackbar หลังปิด loading
            showSnackbarBottom(
                context, 'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_login.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInDown(
                              duration: Duration(milliseconds: 500),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 90.h,
                                    child:
                                        Image.asset('assets/images/logo.png'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            FadeInDown(
                              duration: Duration(milliseconds: 650),
                              child: Text(
                                'กรมทางหลวงชนบท',
                                style: AppTextStyle.header32bold(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            FadeInDown(
                              duration: Duration(milliseconds: 600),
                              child: Text(
                                'Vehicle Inspection System',
                                style: AppTextStyle.header22bold(
                                  color: const Color(0xFF56E4EE),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 40.h),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 600),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  'ชื่อผู้ใช้งาน',
                                                  style:
                                                      AppTextStyle.title14bold(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: usernameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            style: AppTextStyle.title14normal(),
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "ชื่อผู้ใช้งาน",
                                              hintStyle:
                                                  AppTextStyle.title16normal(
                                                      color:
                                                          ColorApps.colorGray),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiaryContainer,
                                                  width: 1,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Icon(
                                                  Icons.visibility_off_outlined,
                                                  size: 20.h,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                ),
                                              ),
                                              errorStyle:
                                                  AppTextStyle.label12bold(
                                                      color: Colors.red),
                                            ),
                                            validator: validateUsername,
                                            onChanged: (v) => formKey
                                                .currentState!
                                                .validate(),
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  'รหัสผ่าน',
                                                  style:
                                                      AppTextStyle.title14bold(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextFormField(
                                            controller: passwordController,
                                            obscureText: isVisibility,
                                            textInputAction:
                                                TextInputAction.next,
                                            style: AppTextStyle.title14normal(),
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "รหัสผ่าน",
                                              hintStyle:
                                                  AppTextStyle.title16normal(
                                                      color:
                                                          ColorApps.colorGray),
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiaryContainer,
                                                  width: 1,
                                                ),
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isVisibility =
                                                        !isVisibility;
                                                  });
                                                },
                                                child: isVisibility
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child: Icon(
                                                          Icons
                                                              .visibility_off_outlined,
                                                          size: 20.h,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child: Icon(
                                                          Icons
                                                              .visibility_outlined,
                                                          size: 20.h,
                                                        ),
                                                      ),
                                              ),
                                              errorStyle:
                                                  AppTextStyle.label12bold(
                                                      color: Colors.red),
                                            ),
                                            validator: validatePassword,
                                            onChanged: (v) => formKey
                                                .currentState!
                                                .validate(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 700),
                                      child: Container(
                                        width: double.infinity,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [0.0, 1.0],
                                            colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ],
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            disabledForegroundColor: Colors
                                                .transparent
                                                .withOpacity(0.38),
                                            disabledBackgroundColor: Colors
                                                .transparent
                                                .withOpacity(0.12),
                                            shadowColor: Colors.transparent,
                                          ),
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                    .validate() ==
                                                false) {
                                              showSnackbarBottom(context,
                                                  'กรุณากรอก ชื่อผู้ใช้งาน หรือ รหัสผ่าน');
                                            } else {
                                              final username =
                                                  usernameController.text;
                                              final password =
                                                  passwordController.text;

                                              final loginBody = LoginModelReq(
                                                username: username.trim(),
                                                password: password,
                                              );

                                              postLogin(loginBody);
                                            }
                                          },
                                          child: Text(
                                            'เข้าสู่ระบบ',
                                            style: AppTextStyle.title14bold(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.h),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 700),
                                      child: Text(
                                        "สมัครสมาชิกเพื่อเริ่มใช้งานครั้งแรก\nกรุณาติดต่อผู้ดูแลระบบ",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.label12normal(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                      ),
                                    ),
                                  ],
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
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
