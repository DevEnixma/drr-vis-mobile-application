import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/constants/text_style.dart';

class VideoWidget extends StatefulWidget {
  final String title;
  final String vdoUrl;
  const VideoWidget({super.key, required this.title, required this.vdoUrl});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.vdoUrl))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _controller.value.isInitialized
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 18.h),
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h, right: 5.h, left: 2.h),
                            child: SvgPicture.asset(
                              'assets/svg/lucide_cctv.svg',
                              // ignore: deprecated_member_use
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 20.h,
                            ),
                          ),
                          Text(
                            widget.title,
                            style: AppTextStyle.title14bold(),
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
        // IconButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying ? _controller.pause() : _controller.play();
        //     });
        //   },
        //   icon: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
