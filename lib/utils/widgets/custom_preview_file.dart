import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../main.dart';
import '../../service/token_refresh.service.dart';
import '../../local_storage.dart';
import '../constants/key_localstorage.dart';
import '../constants/text_style.dart';

class CustomPreviewFile extends StatefulWidget {
  const CustomPreviewFile({
    super.key,
    required this.url,
    required this.fileName,
  });

  final String url;
  final String fileName;

  @override
  State<CustomPreviewFile> createState() => _CustomPreviewFileState();
}

class _CustomPreviewFileState extends State<CustomPreviewFile> {
  File? _downloadedFile;
  String? _errorMessage;
  bool _isSharing = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  final LocalStorage _storage = LocalStorage();

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<String?> _getAccessToken() async {
    try {
      final token = await _storage.getValueString(KeyLocalStorage.accessToken);
      if (token != null && token.isNotEmpty) {
        return token;
      }
      return null;
    } catch (e) {
      logger.e('Error getting access token: $e');
      return null;
    }
  }

  Future<void> _downloadPdf() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
      _errorMessage = null;
      _downloadProgress = 0.0;
    });

    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${widget.fileName}';

      final file = File(filePath);
      if (await file.exists()) {
        setState(() {
          _downloadedFile = file;
          _isDownloading = false;
          _downloadProgress = 1.0;
        });
        return;
      }

      final accessToken = await _getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('ไม่พบ Access Token กรุณาเข้าสู่ระบบใหม่');
      }

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.options.receiveTimeout = const Duration(minutes: 10);
      dio.options.connectTimeout = const Duration(minutes: 2);

      await dio.download(
        widget.url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      final downloadedFile = File(filePath);
      if (!await downloadedFile.exists()) {
        throw Exception('ไม่สามารถบันทึกไฟล์ได้');
      }

      final fileSize = await downloadedFile.length();
      if (fileSize == 0) {
        throw Exception('ไฟล์ที่ดาวน์โหลดมีขนาด 0 bytes');
      }

      if (mounted) {
        setState(() {
          _downloadedFile = downloadedFile;
          _isDownloading = false;
          _downloadProgress = 1.0;
        });
      }
    } on DioException catch (e) {
      logger.e('DioException: ${e.type} - ${e.message}');
      logger.e('Status Code: ${e.response?.statusCode}');

      String errorMsg = 'ไม่สามารถดาวน์โหลดไฟล์ได้';

      if (e.response?.statusCode == 401) {
        errorMsg = 'หมดเวลาเข้าใช้งาน กรุณาเข้าสู่ระบบใหม่';
      } else if (e.response?.statusCode == 404) {
        errorMsg = 'ไม่พบไฟล์ที่ต้องการ';
      } else if (e.response?.statusCode == 403) {
        errorMsg = 'ไม่มีสิทธิ์เข้าถึงไฟล์นี้';
      } else if (e.response?.statusCode == 504) {
        errorMsg =
            'เซิร์ฟเวอร์ใช้เวลาสร้างเอกสารนานเกินไป\nกรุณาลองใหม่อีกครั้ง';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = 'เชื่อมต่อเซิร์ฟเวอร์ล้มเหลว';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMsg = 'ดาวน์โหลดไฟล์ใช้เวลานานเกินไป\nกรุณาลองใหม่อีกครั้ง';
      } else if (e.type == DioExceptionType.unknown &&
          e.error is SocketException) {
        errorMsg = 'ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้';
      }

      if (mounted) {
        setState(() {
          _errorMessage = errorMsg;
          _isDownloading = false;
        });
      }
    } catch (e) {
      logger.e('Download error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'เกิดข้อผิดพลาด: ${e.toString()}';
          _isDownloading = false;
        });
      }
    }
  }

  Future<void> _shareFile() async {
    if (_downloadedFile == null || _isSharing) return;

    setState(() => _isSharing = true);

    try {
      if (!await _downloadedFile!.exists()) {
        throw Exception('ไฟล์ไม่พบ');
      }

      final fileSize = await _downloadedFile!.length();
      logger.i('File size: $fileSize bytes');

      if (fileSize == 0) {
        throw Exception('ไฟล์มีขนาด 0 bytes');
      }

      final xfile = XFile(
        _downloadedFile!.path,
        name: widget.fileName,
        mimeType: 'application/pdf',
      );

      logger.i('Sharing file from: ${xfile.path}');

      final box = context.findRenderObject() as RenderBox?;
      final sharePositionOrigin =
          box != null ? box.localToGlobal(Offset.zero) & box.size : null;

      logger.i('Share position origin: $sharePositionOrigin');

      final result = await Share.shareXFiles(
        [xfile],
        subject: widget.fileName,
        sharePositionOrigin: sharePositionOrigin,
      );

      logger.i('Share result status: ${result.status}');
    } catch (e, stackTrace) {
      logger.e('Share error: $e');
      logger.e('Stack trace: $stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ไม่สามารถแชร์ไฟล์ได้: $e'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'เอกสาร',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        actions: [
          if (_downloadedFile != null)
            IconButton(
              icon: _isSharing
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    )
                  : Icon(
                      Icons.ios_share,
                      color: Theme.of(context).colorScheme.surface,
                    ),
              onPressed: _isSharing ? null : _shareFile,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _errorMessage = null);
                  _downloadPdf();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('ลองใหม่'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isDownloading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: _downloadProgress > 0 ? _downloadProgress : null,
                strokeWidth: 6,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _downloadProgress > 0
                  ? 'กำลังดาวน์โหลด ${(_downloadProgress * 100).toStringAsFixed(0)}%'
                  : 'กำลังเตรียมเอกสาร...',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.fileName,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    if (_downloadedFile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SfPdfViewer.file(
      _downloadedFile!,
      onDocumentLoadFailed: (details) {
        logger.e('PDF load failed: ${details.error} - ${details.description}');
        setState(() {
          _errorMessage = 'ไม่สามารถโหลด PDF ได้: ${details.description}';
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
