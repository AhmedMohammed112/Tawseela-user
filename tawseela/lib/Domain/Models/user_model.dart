import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String id;
  String name;
  String email;
  String phone;
  String address;
  String image;
  int trips;
  int freeTrips;
  List<dynamic> discounts;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
    required this.trips,
    required this.freeTrips,
    required this.discounts,
  });



}