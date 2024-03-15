import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/Data/Response/current_user_info-response.dart';

class RequestDetailsInfoResponse extends BaseResponse
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

  RequestDetailsInfoResponse({
    this.id,
    required this.userId,
    required this.driverId,
    this.rating,
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

  factory RequestDetailsInfoResponse.fromJson(DataSnapshot json) => RequestDetailsInfoResponse(
    id: json.key,
    userId: (json.value as dynamic)['user_id'],
    driverId: (json.value as dynamic)['driver_id'],
    rating: (json.value as dynamic)['rate'] == null ? 0.0 : double.parse((json.value as dynamic)['rate'].toString()),
    userName: (json.value as dynamic)['user_name'], 
    userPhone: (json.value as dynamic)['user_phone'],
    originAddress: (json.value as dynamic)['origin_address'], 
    originLat: (json.value as dynamic)['origin_lat'],
    originLng: (json.value as dynamic)['origin_lng'], 
    destinationAddress: (json.value as dynamic)['destination_address'], 
    destinationLat: (json.value as dynamic)['destination_lat'], 
    destinationLng: (json.value as dynamic)['destination_lng'],
    date: (json.value as dynamic)['date'], 
    fareAmount: double.parse((json.value as dynamic)['fare_amount'].toString()),
    tripStatus: (json.value as dynamic)['trip_status'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "driver_id": driverId, 
    "user_name": userName,
    "user_phone": userPhone,
    "origin_address": originAddress,
    "origin_lat": originLat,
    "origin_lng": originLng,
    "destination_address": destinationAddress,
    "destination_lat": destinationLat,
    "destination_lng": destinationLng,
    "date": date,
    "fare_amount": fareAmount,
    "trip_status": tripStatus,
  };



} 
