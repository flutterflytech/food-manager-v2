import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String userEmail;
  String userEmpId;
  String userSurname;
  String userFName;
  String qrData;
  String uid;

  Record(this.userEmail, this.userEmpId, this.userSurname, this.userFName,
      this.qrData, this.uid);

  Record.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        qrData = map['qrData'],
        userEmail = map['email'],
        userEmpId = map['empId'],
        userFName = map['fname'],
        userSurname = map['surname'];

  Record.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    qrData = json['qrData'];
    userEmail = json['email'];
    userEmpId = json['empId'];
    userFName = json['fname'];
    userSurname = json['surname'];
  }

  Map<String, dynamic> toJson() =>
      {
        'uid' : uid,
        'qrData' : qrData,
        'userEmpId' : userEmpId
      };

  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  String toString() {
    return '{"email": "$userEmail", "empId": "$userEmpId", "fname": "$userFName","surname": "$userSurname", "qrData":"$qrData", "uid":"$uid" }';
  }
}
