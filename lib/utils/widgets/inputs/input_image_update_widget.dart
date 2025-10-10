import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/profile/profile_bloc.dart';
import '../../constants/color_app.dart';
import '../../constants/text_style.dart';
import '../../libs/role_permission.dart';

class InputImageUpdateWidget extends StatefulWidget {
  const InputImageUpdateWidget({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.keyName,
    required this.onSelectImage,
    required this.isDisable,
  });

  final String imageUrl;
  final String label;
  final String keyName;
  final Function(String, String) onSelectImage;
  final bool isDisable;

  @override
  State<InputImageUpdateWidget> createState() => _InputImageUpdateWidgetState();
}

class _InputImageUpdateWidgetState extends State<InputImageUpdateWidget> {
  final ImagePicker _picker = ImagePicker();

  File? imagePath;

  Future<void> _pickImage(String type, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        widget.onSelectImage(widget.keyName, image.path);
        setState(() {
          imagePath = File(image.path);
        });
      }
    } catch (e) {
      // Handle image picker errors
      debugPrint('Error picking image: $e');
    }
  }

  void isCloseImageUpload() {
    setState(() {
      imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safe role access with null checking
    final profileState = context.read<ProfileBloc>().state;
    final profile = profileState.profile;
    final role = profile?.deptType;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: MediaQuery.of(context).size.width / 2 - 32,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppTextStyle.title16bold(),
              ),
            ],
          ),
          if (imagePath == null)
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.imageUrl.isNotEmpty) {
                      showPreviewImageUrl(context, widget.imageUrl);
                    } else {
                      if (RolePermission.checkRoleViewer(role) && widget.isDisable) {
                        select_photo_bottom_sheet(
                          context,
                          () {
                            _pickImage(widget.keyName, ImageSource.camera);
                            Navigator.pop(context);
                          },
                          () {
                            _pickImage(widget.keyName, ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        );
                      }
                    }
                  },
                  child: widget.imageUrl.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.all(8),
                          height: 150.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(color: ColorApps.grayBorder),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              widget.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.grey[600],
                                        size: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'ไม่สามารถโหลดรูปภาพได้',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.all(8),
                          height: 150.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(color: ColorApps.grayBorder),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.add),
                        ),
                ),
                if (widget.imageUrl.isNotEmpty && RolePermission.checkRoleViewer(role) && widget.isDisable)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: IconButton(
                      icon: const Icon(
                        Icons.image,
                        color: ColorApps.colorText,
                      ),
                      tooltip: 'เปลี่ยนรูปภาพ',
                      onPressed: () {
                        select_photo_bottom_sheet(
                          context,
                          () {
                            _pickImage(widget.keyName, ImageSource.camera);
                            Navigator.pop(context);
                          },
                          () {
                            _pickImage(widget.keyName, ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          if (imagePath != null)
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    final imageFile = imagePath;
                    if (imageFile != null) {
                      showPreviewImage(context, imageFile);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 150.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(color: ColorApps.grayBorder),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: imagePath != null
                          ? Image.file(
                              imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.grey[600],
                                        size: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'ไม่สามารถโหลดรูปภาพได้',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorApps.colorRed,
                    ),
                    tooltip: 'ลบรูปภาพ',
                    onPressed: () {
                      isCloseImageUpload();
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<dynamic> select_photo_bottom_sheet(BuildContext context, Function() tab_camera, Function() tab_gallery) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: tab_camera,
                child: Row(
                  children: [
                    Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(90.r)),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.h,
                        )),
                    SizedBox(width: 12.w),
                    Text(
                      'เปิดกล้องถ่ายรูป',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: tab_gallery,
                child: Row(
                  children: [
                    Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(90.r)),
                        child: Icon(
                          Icons.photo_size_select_actual_outlined,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.h,
                        )),
                    SizedBox(width: 12.w),
                    Text(
                      'เลือกรูปจากคลังภาพ',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showPreviewImage(BuildContext context, File image) {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          content: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.file(
                image,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.grey[600],
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'ไม่สามารถแสดงรูปภาพได้',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showPreviewImageUrl(BuildContext context, String imageUrl) {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          content: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                        ),
                        SizedBox(height: 16),
                        Text('กำลังโหลดรูปภาพ...'),
                      ],
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.grey[600],
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'ไม่สามารถโหลดรูปภาพได้',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
