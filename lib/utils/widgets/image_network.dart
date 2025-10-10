import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../libs/string_helper.dart';
import 'skeletion_widgets/skeletion_v2.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.fitImage,
  });

  final String imageUrl;
  final BoxFit? fitImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: StringHleper.CheckPartUrlImage(imageUrl),
      fit: fitImage != null ? fitImage : BoxFit.cover,
      placeholder: (context, url) => SkeletionV2(height: 65.h, width: 50.w),
      errorWidget: (context, url, error) => Image.asset('assets/images/icon_placeholder_news.png'),
      errorListener: (e) {
        if (e is SocketException) {
          debugPrint('Error with ${e.address} and message ${e.message}');
        } else {
          debugPrint('Image Exception is: ${e.runtimeType}');
        }
      },
    );
    // return imageUrl != null
    //     ? Image.network(
    //         StringHleper.CheckPartUrlImage(imageUrl),
    //         fit: fitImage != null ? fitImage : BoxFit.cover,
    //         loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    //           return SkeletionV2(height: 65.h, width: 50.w);
    //         },
    //         errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
    //           return Image.asset(
    //             'assets/images/logo.png',
    //           );
    //         },
    //       )
    //     : Image.asset(
    //         'assets/images/logo.png',
    //       );
  }
}
