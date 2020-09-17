import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class BookingList {
  // String bookingId;
  // String userId;
  // String vendorId;
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
      // bookingId: json["bookingId"],
      // userId: json["userId"],
      // vendorId: json["vendorId"],
      mealName: json["mealName"],
      vendorName: json["vendorFName"],
      timestamp: json["timeStamp"],
      paymentStatus: json["paymentStatus"],
      mealPrice: json["mealPrice"]);

  @override
  String toString() {
    return 'BookingList{ mealName: $mealName, vendorName: $vendorName, timestamp: $timestamp, paymentStatus: $paymentStatus, mealPrice: $mealPrice}';
  }
// Map<String, dynamic> toJson() => _BookingListToJson(this);

}
