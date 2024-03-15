class PromoCode {
  String? id;
  String? code;
  String? description;
  int? discount;
  int? freeRides;
  bool? status;
  String? createdAt;
  String? expiryDate;
  List<dynamic>? users;

  PromoCode({
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
}