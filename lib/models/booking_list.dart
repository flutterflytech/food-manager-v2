import 'package:json_annotation/json_annotation.dart';

// Model Class for storing List-card details

@JsonSerializable(nullable: false)
class BookingList {
  String mealName;
  String vendorName;
  String timestamp;
  bool paymentStatus;
  int mealPrice;

  BookingList(
      {this.mealName,
      this.vendorName,
      this.timestamp,
      this.paymentStatus,
      this.mealPrice});

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
      mealName: json["mealName"],
      vendorName: json["vendorFName"],
      timestamp: json["timeStamp"],
      paymentStatus: json["paymentStatus"],
      mealPrice: json["mealPrice"]);

  @override
  String toString() {
    return 'BookingList{ mealName: $mealName, vendorName: $vendorName, timestamp: $timestamp, paymentStatus: $paymentStatus, mealPrice: $mealPrice}';
  }
}
