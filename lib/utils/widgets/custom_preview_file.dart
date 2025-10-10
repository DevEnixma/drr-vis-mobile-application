import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../main.dart';
import '../../service/token_refresh.service.dart';
import '../constants/text_style.dart';

class CustomPreviewFile extends StatefulWidget {
  const CustomPreviewFile({
    super.key,
    this.url,
    this.nameFile,
  });

  final String? url;
  final String? nameFile;

  @override
  State<CustomPreviewFile> createState() => _CustomPreviewFileState();
}

class _CustomPreviewFileState extends State<CustomPreviewFile> {
  File? downloadedFile;

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() async {
    if (widget.url != null) {
      final file = await downloadAndOpenPdf(widget.url!, widget.nameFile!);

      setState(() {
        downloadedFile = file;
      });
    }
  }

  Future<File?> downloadAndOpenPdf(String url, String filename) async {
    try {
      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$filename';

      // Download the file
      final dio = Dio();
      await dio.download(url, filePath);
      print('File downloaded to $filePath');

      return File(filePath);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<File?> downloadAndSavePdf(BuildContext context, String url, String filename) async {
    try {
      Directory? directory;

      if (Platform.isAndroid) {
        // Show permission request modal
        final status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          final result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Permission Required"),
              content: const Text("This app needs permission to save files to your device."),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Grant'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );

          if (result == true) {
            await Permission.manageExternalStorage.request(); // Request permission after user clicks "Grant"
            if (await Permission.manageExternalStorage.isGranted) {
              // Check if permission is granted after request
              directory = Directory('/storage/emulated/0/Download'); // Downloads folder
            } else {
              // Permission denied after request
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Permission Denied"),
                  content: const Text("Permission to save files was denied."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
              return null;
            }
          } else {
            // User cancelled the permission request
            return null;
          }
        } else {
          directory = Directory('/storage/emulated/0/Download'); // Permission already granted
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) return null;

      final filePath = '${directory.path}/$filename';
      final dio = Dio();
      await dio.download(url, filePath);

      return File(filePath);
    } catch (e) {
      logger.e('==111==downloadAndSavePdf==error==> ${e}');
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
        title: Text(
          'เอกสาร',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              // downloadAndSavePdf(context, widget.url!, widget.nameFile!);
              // final file = await _loadPdfFromAssets();
              // final xfile = XFile(file.path, mimeType: 'application/pdf');
              // Share.shareXFiles([xfile]);
              final file = await downloadAndSavePdf(context, widget.url!, widget.nameFile!);
              if (file != null) {
                final xfile = XFile(file.path, mimeType: 'application/pdf');
                Share.shareXFiles([xfile]);
              } else {
                logger.e("Failed to download the file for sharing.");
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.h),
              child: SvgPicture.asset('assets/svg/material-symbols_upload-file-outline.svg'),
            ),
          )
        ],
      ),
      body: downloadedFile != null
          ? SfPdfViewer.file(downloadedFile!)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<File> _loadPdfFromAssets() async {
    // Load the PDF from assets folder

    final byteData = await rootBundle.load('assets/sample.pdf');

    // Get the app's directory to store the file temporarily
    final directory = await getApplicationDocumentsDirectory();

    // Create a new file in that directory
    final file = File('${directory.path}/${widget.nameFile!}');

    // Write the PDF data into the file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file;
  }
}
