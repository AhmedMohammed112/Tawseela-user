import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Domain/Models/active_nearby_drivers.dart';

class GeoFireGetNearbyDriversEventHelper {
  static List<ActiveNearbyDriver> activeDrivers = [];

  static void deleteOfflineDriver(String id) {
    int index = activeDrivers.indexWhere((element) => element.id == id);
    activeDrivers.removeAt(index);
  }

  static void updateDriverNearbyLocation(String id, LatLng latLng) {
    int index = activeDrivers.indexWhere((element) => element.id == id);
    activeDrivers[index].lat = latLng.latitude;
    activeDrivers[index].lng = latLng.longitude;
  }
}