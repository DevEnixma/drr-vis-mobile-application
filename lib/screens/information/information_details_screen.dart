import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/data/models/news/news_model_res.dart';
import 'package:wts_bloc/service/token_refresh.service.dart';

import '../../app/routes/routes.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/html_content/html_fullcontent_widget.dart';

class InformationDetailsScreen extends StatefulWidget {
  const InformationDetailsScreen({
    super.key,
    required this.item,
  });

  final NewsModelRes item;

  @override
  State<InformationDetailsScreen> createState() =>
      _InformationDetailsScreenState();
}

class _InformationDetailsScreenState extends State<InformationDetailsScreen> {
  int isFile = 0;

  List<FileAttached> files = [];

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() async {
    if (widget.item.fileAttached1 != null && widget.item.fileAttached1 != '') {
      isFile += 1;
      files.add(FileAttached(
          url: widget.item.fileAttached1.toString(), name: 'เอกสารแนบ 1.pdf'));
    }
    if (widget.item.fileAttached2 != null && widget.item.fileAttached2 != '') {
      isFile += 1;
      files.add(FileAttached(
          url: widget.item.fileAttached2.toString(), name: 'เอกสารแนบ 2.pdf'));
    }
    if (widget.item.fileAttached3 != null && widget.item.fileAttached3 != '') {
      isFile += 1;
      files.add(FileAttached(
          url: widget.item.fileAttached3.toString(), name: 'เอกสารแนบ 3.pdf'));
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'ข่าวสาร',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(
              color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(height: 60.w),
                  Container(
                    // height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffDCDCDC),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22.0),
                      child: Image.network(
                        widget.item.newsImage!,
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
                  SizedBox(height: 15),
                  // Row(
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           widget.item.newsHeader ?? '-',
                  //           style: AppTextStyle.title14normal(),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   height: 25,
                  // ),
                  HtmlFullcontentWidget(
                      item: widget.item.newsContent.toString()),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ไฟล์เอกสารที่แนบ',
                            style: AppTextStyle.title16bold()),
                        Text('${files.length} รายการ',
                            style: AppTextStyle.title16bold(
                                color:
                                    Theme.of(context).colorScheme.onTertiary)),
                      ],
                    ),
                  ),
                  for (var item in files)
                    GestureDetector(
                      onTap: () {
                        Routes.gotoPreviewFile(
                            context: context,
                            url: item.url.toString(),
                            nameFile: item.name.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 12.h),
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/ph_file-duotone.svg'),
                            SizedBox(width: 5.h),
                            Text(
                              item.name.toString(),
                              style: AppTextStyle.title14normal(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.h),
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  maxLines: 2,
                  widget.item.newsHeader ?? '-',
                  style: AppTextStyle.title16bold(
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FileAttached {
  String? url;
  String? name;

  FileAttached({this.url, this.name});

  FileAttached.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}
