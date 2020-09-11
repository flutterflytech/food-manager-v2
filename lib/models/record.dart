import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String userEmail;
  String userEmpId;
  String userSurname;
  String userFName;
  String qrData;
  String uid;
  String time;
  int mealType;
  int mealPrice;
  String mealName;

  Record(this.userEmail, this.userEmpId, this.userSurname, this.userFName,
      this.qrData, this.uid, this.time, this.mealType, this.mealPrice, this.mealName);

  Record.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        qrData = map['qrData'],
        userEmail = map['email'],
        userEmpId = map['empId'],
        userFName = map['fname'],
        userSurname = map['surname'];


  Record.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    time = json['time'];
    qrData = json['qrData'];
    userEmail = json['email'];
    userEmpId = json['empId'];
    userFName = json['fname'];
    userSurname = json['surname'];
    mealType = json['mealType'];
    mealPrice = json['mealPrice'];
    mealName = json['mealName'];
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'time': qrData, 'userEmpId': userEmpId};

  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  @override
  String toString() {
    return 'Record{userEmail: $userEmail, userEmpId: $userEmpId, userSurname: $userSurname, userFName: $userFName, qrData: $qrData, uid: $uid, time: $time, mealType: $mealType, mealPrice: $mealPrice, mealName: $mealName}';
  }
}

class Bookings{
  final String date;
  final int sales;

  Bookings(this.date, this.sales);
}