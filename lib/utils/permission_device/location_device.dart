import 'package:geolocator/geolocator.dart';

import '../../local_storage.dart';
import '../../main.dart';
import '../constants/key_localstorage.dart';

final LocalStorage storage = LocalStorage();

Future<void> getCurrentLocation() async {
  try {
    logger.i('============[getCurrentLocation]============');

    Position position = await getGeoLocationPosition();
    await storage.setValueDouble(KeyLocalStorage.lat, position.latitude);
    await storage.setValueDouble(KeyLocalStorage.lng, position.longitude);
    logger.i('===========Latitude: ${position.latitude}');
    logger.i('===========Longitude: ${position.longitude}');
  } catch (e) {
    logger.e('====== Error getting location: $e');
  }
}

Future<Position> getGeoLocationPosition() async {
  logger.i('============[getGeoLocationPosition]============');
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    logger.e('Location services are disabled.');
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await storage.setValueBool(KeyLocalStorage.permissionAllowLocation, false);
      logger.e('Location permissions are denied');
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    await storage.setValueBool(KeyLocalStorage.permissionAllowLocation, false);
    logger.e('Location permissions are permanently denied, we cannot request permissions.');
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  await storage.setValueBool(KeyLocalStorage.permissionAllowLocation, true);
  return await Geolocator.getCurrentPosition();
}
