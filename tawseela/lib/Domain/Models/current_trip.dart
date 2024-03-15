import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'driver_model.dart';

class CurrentTrip {
  String? selectedVehicle; // Selected Vehicle Type
  String driverId;
  LatLng? driverLocation;
  String? tripStatus ;
  String? tStatus;
  String? rideRequestId;
  double? fareAmount;
  String? tempRideRequestId;
  AssignedDriver? assignedDriver;
  AssignedDriver? tempAssignedDriver;

  CurrentTrip({
    this.selectedVehicle,
    this.driverId = 'Waiting',
    this.driverLocation,
    this.tripStatus,
    this.tStatus = '',
    this.rideRequestId,
    this.fareAmount,
    this.tempRideRequestId,
    this.assignedDriver,
    this.tempAssignedDriver,
  });
}