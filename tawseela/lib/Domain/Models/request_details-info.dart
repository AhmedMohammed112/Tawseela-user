class RequestDetailsInfo
{
  String? id;
  String userId;
  String driverId;
  double? rating;
  String userName; 
  String userPhone;
  String originAddress;
  double originLat;
  double originLng;
  String destinationAddress;
  double destinationLat;
  double destinationLng;
  String date;
  double fareAmount;
  String tripStatus;

  RequestDetailsInfo({
    this.id,
    required this.userId,
    this.rating,
    required this.driverId, 
    required this.userName, 
    required this.userPhone,
    required this.originAddress,
    required this.originLat,
    required this.originLng,
    required this.destinationAddress,
    required this.destinationLat,
    required this.destinationLng,
    required this.date,
    required this.fareAmount,
    required this.tripStatus,
  });
}