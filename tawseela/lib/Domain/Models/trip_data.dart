import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Models/request_details-info.dart';

import '../../Data/Response/request_details_info_response.dart';

class TripData
{
  String tripId;
  RequestDetailsInfoResponse requestDetailsInfo;
  AssignedDriver assignedDriver;

  TripData({
    required this.tripId,
    required this.requestDetailsInfo,
    required this.assignedDriver,
  });

  // convert json to TripData String
}