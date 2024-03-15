import 'package:firebase_database/firebase_database.dart';

class AssignedDriver
{
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? token;
  double rating = 0.0;
  int? trips = 0;
  double earnings = 0.0;
  List<Review> review = [];
  Vehicle? vehicle;

  AssignedDriver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
    required this.token,
    required this.vehicle,
    required this.rating,
    required this.trips,
    required this.earnings,
    required this.review,
  });
}

class Vehicle
{
  String? name;
  String? model;
  String? color;
  String? plateNumber;
  String? type;

  Vehicle({
    required this.name,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.type,
  });
}

class Review
{
  String id;
  String name;
  String image;
  double rate;
  String comment;

  Review({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.comment,
  });

  // convert review to map
  Map<String, dynamic> toMap() =>
    {
      'id': id,
      'name': name,
      'image': image,
      'rate': rate,
      'comment': comment,
    };

  // convert list of reviews to list of maps
  List<Map<String, dynamic>> toMapList(List<Review> reviews) {
    List<Map<String, dynamic>> reviewsMap = [];
    reviews.forEach((review) {
      reviewsMap.add(review.toMap());
    });
    return reviewsMap;
  }
}

