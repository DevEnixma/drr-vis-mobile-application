import 'dart:math';

class MapPositionHleper {
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // รัศมีโลก (กิโลเมตร)
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) + cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // ระยะทาง (กิโลเมตร)
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  static String calculateMiddleAndDistance(double latStart, double lonStart, double latEnd, double lonEnd) {
    // คำนวณพิกัดกึ่งกลาง
    final latMid = (latStart + latEnd) / 2;
    final lonMid = (lonStart + lonEnd) / 2;

    // คำนวณระยะทางทั้งหมด
    final totalDistance = calculateDistance(latStart, lonStart, latEnd, lonEnd);

    // คำนวณระยะทางจากจุดเริ่มต้นไปจุดกึ่งกลาง
    final distanceToMid = calculateDistance(latStart, lonStart, latMid, lonMid) * 1000;

    return distanceToMid.toStringAsFixed(2);
  }
}
