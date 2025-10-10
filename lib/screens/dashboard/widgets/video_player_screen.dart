import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/constants/text_style.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String vdoUrl;
  const VideoPlayerScreen({super.key, required this.title, required this.vdoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Validate URL before creating controller
      if (widget.vdoUrl.isEmpty) {
        throw Exception('Video URL is empty');
      }

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.vdoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      // Add listener for player state changes
      _videoPlayerController.addListener(_videoPlayerListener);

      await _videoPlayerController.initialize();

      // Only create Chewie controller if video is successfully initialized
      if (_videoPlayerController.value.isInitialized) {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: false, // Changed to false for better UX
          looping: false, // Changed to false - let user decide
          aspectRatio: _videoPlayerController.value.aspectRatio,
          showControls: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Theme.of(context).primaryColor,
            handleColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.grey.shade300,
          ),
          placeholder: Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorBuilder: (context, errorMessage) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Failed to load video',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to initialize video player');
      }
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  void _videoPlayerListener() {
    if (_videoPlayerController.value.hasError) {
      setState(() {
        _hasError = true;
        _errorMessage = _videoPlayerController.value.errorDescription ?? 'Unknown error';
      });
    }
  }

  Future<void> _retryVideo() async {
    await _disposeControllers();
    await _initializePlayer();
  }

  Future<void> _disposeControllers() async {
    _videoPlayerController.removeListener(_videoPlayerListener);
    await _videoPlayerController.dispose();
    _chewieController?.dispose();
    _chewieController = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 18.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Header with title
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
              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.title14bold(),
                ),
              )
            ],
          ),

          // Video player section
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 200.h,
              width: double.infinity,
              color: Colors.black,
              child: _buildVideoWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoWidget() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.h,
            ),
            SizedBox(height: 4.h),
            Text(
              'Failed to load video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton.icon(
              onPressed: _retryVideo,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }

    return const Center(
      child: Text(
        'Video not available',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
