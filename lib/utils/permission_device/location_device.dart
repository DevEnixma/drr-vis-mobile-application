import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../local_storage.dart';
import '../../main.dart';
import '../constants/key_localstorage.dart';

final LocalStorage storage = LocalStorage();

Future<bool> requestLocationPermissionWithDisclosure(
    BuildContext context) async {
  try {
    logger
        .i('============[requestLocationPermissionWithDisclosure]============');

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final shouldOpen = await _showLocationServiceDialog(context);
      if (shouldOpen == true) {
        await Geolocator.openLocationSettings();
      }
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await _showPermissionDeniedForeverDialog(context);
      await storage.setValueBool(
          KeyLocalStorage.permissionAllowLocation, false);
      return false;
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      final shouldRequest = await _showLocationDisclosureDialog(context);

      if (shouldRequest != true) {
        await storage.setValueBool(
            KeyLocalStorage.permissionAllowLocation, false);
        return false;
      }

      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await storage.setValueBool(
            KeyLocalStorage.permissionAllowLocation, false);
        logger.e('Location permissions are denied');
        return false;
      }
    }

    await storage.setValueBool(KeyLocalStorage.permissionAllowLocation, true);
    logger.i('Location permission granted');
    return true;
  } catch (e) {
    logger.e('====== Error requesting location permission: $e');
    await storage.setValueBool(KeyLocalStorage.permissionAllowLocation, false);
    return false;
  }
}

Future<bool?> _showLocationDisclosureDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('การเข้าถึงตำแหน่ง'),
      content: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'แอปพลิเคชันต้องการเข้าถึงตำแหน่งของคุณเพื่อ:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• บันทึกเส้นทางการตรวจสอบรถอย่างแม่นยำ'),
            Text('• สร้างรายงานการเดินทางที่สมบูรณ์'),
            Text('• ยืนยันความถูกต้องของการตรวจสอบในภาคสนาม'),
            SizedBox(height: 12),
            Text(
              'ข้อมูลตำแหน่งจะถูกใช้เฉพาะระหว่างการปฏิบัติงานและจะถูกเก็บรักษาอย่างปลอดภัย',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('ไม่อนุญาต'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('อนุญาต'),
        ),
      ],
    ),
  );
}

Future<bool?> _showLocationServiceDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('เปิด Location Service'),
      content: const Text(
        'กรุณาเปิด Location Service ในการตั้งค่าเพื่อใช้งานระบบตรวจสอบรถ',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('ยกเลิก'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('เปิดการตั้งค่า'),
        ),
      ],
    ),
  );
}

Future<void> _showPermissionDeniedForeverDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('ไม่สามารถเข้าถึงตำแหน่ง'),
      content: const Text(
        'คุณได้ปฏิเสธการเข้าถึงตำแหน่งถาวร\n\n'
        'กรุณาไปที่การตั้งค่าแอป > สิทธิ์ > ตำแหน่ง\n'
        'เพื่ออนุญาตการเข้าถึงตำแหน่ง',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ปิด'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Geolocator.openAppSettings();
          },
          child: const Text('ไปที่การตั้งค่า'),
        ),
      ],
    ),
  );
}

Future<Position?> getCurrentLocation() async {
  try {
    logger.i('============[getCurrentLocation]============');

    final hasPermission = await storage.getValueBool(
      KeyLocalStorage.permissionAllowLocation,
    );

    if (!hasPermission) {
      logger.e('Location permission not granted');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await storage.setValueDouble(KeyLocalStorage.lat, position.latitude);
    await storage.setValueDouble(KeyLocalStorage.lng, position.longitude);

    logger.i('Latitude: ${position.latitude}');
    logger.i('Longitude: ${position.longitude}');

    return position;
  } catch (e) {
    logger.e('Error getting location: $e');
    return null;
  }
}
