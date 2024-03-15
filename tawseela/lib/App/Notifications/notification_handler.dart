import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class NotificationHandler {

  static void sendNotificationToDriver(
      String deviceRegistrationToken,
      String userRideRequest,
      String pickUpAddress,
      BuildContext context,
      ) async {
    String destination = pickUpAddress;

    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': AppConstants.cloudMessagingServerToken,
    };


    Map bodyNotification = {
      'notification': {
        'title': 'New Ride Request',
        'body': 'This is a ride request from $destination',
        'sound': 'default',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'message': 'This is a ride request from $destination',
        'status': 'done',
        'rideRequestId': userRideRequest,
      },
      'priority': 'high',
      'to': deviceRegistrationToken,
    };

    http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerNotification,
      body: jsonEncode(bodyNotification),
    );
  }
}