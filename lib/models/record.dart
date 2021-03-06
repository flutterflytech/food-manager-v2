import 'package:cloud_firestore/cloud_firestore.dart';

// Model class for saving booking data fetched from firestore

class Record {
  String userEmail;
  String userEmpId;
  String userSurname;
  String userFName;
  String uid;
  int mealType;
  int mealPrice;
  String mealName;

  Record(this.userEmail, this.userEmpId, this.userSurname, this.userFName,
       this.uid, this.mealType, this.mealPrice, this.mealName);

  Record.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        userEmail = map['email'],
        userEmpId = map['empId'],
        userFName = map['fname'],
        userSurname = map['surname'];

  Record.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userEmail = json['email'];
    userEmpId = json['empId'];
    userFName = json['fname'];
    userSurname = json['surname'];
    mealType = json['mealType'];
    mealPrice = json['mealPrice'];
    mealName = json['mealName'];
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'userEmpId': userEmpId};

  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  @override
  String toString() {
    return 'Record{userEmail: $userEmail, userEmpId: $userEmpId, userSurname: $userSurname, userFName: $userFName, uid: $uid,  mealType: $mealType, mealPrice: $mealPrice, mealName: $mealName}';
  }
}

// class Bookings {
//   final String date;
//   final int sales;
//
//   Bookings(this.date, this.sales);
// }
