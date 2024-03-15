import 'package:firebase_database/firebase_database.dart';

class PromoCodeResponse {
  String? id;
  String? code;
  String? description;
  int? discount;
  int? freeRides;
  bool? status;
  String? createdAt;
  String? expiryDate;
  List<dynamic>? users;

  PromoCodeResponse({
    this.id,
    this.code,
    this.description,
    this.discount,
    this.freeRides,
    this.status,
    this.createdAt,
    this.expiryDate,
    this.users,
  });

factory PromoCodeResponse.fromJson(DataSnapshot snapshot) {
    return PromoCodeResponse(
      id: snapshot.key,
      code: (snapshot.value as dynamic)['code'],
      description: (snapshot.value as dynamic)['description'],
      discount: (snapshot.value as dynamic)['discount'],
      freeRides: (snapshot.value as dynamic)['free_trips'],
      status: (snapshot.value as dynamic)['status'],
      createdAt: (snapshot.value as dynamic)['createdAt'],
      expiryDate: (snapshot.value as dynamic)['expiryDate'],
      users: (snapshot.value as dynamic)['users']?.map((e) => e.toString()).toList(),
    );
  }
}