import 'dart:async';

import 'package:location/location.dart';

class ServiceLocation {
  static Future<PermissionStatus> requestPermission() {
    return Location().requestPermission();
  }

  static Stream<LocationData> streamLocation() {
    return Location().onLocationChanged;
  }

  static Future<LocationData> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permission;
    serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Location().hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await Location().requestPermission();
      if (permission == PermissionStatus.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == PermissionStatus.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Location().getLocation();
  }
}
