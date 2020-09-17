// User Model

class User {
  final String uid;

  User({this.uid});
}

// user model for receiving data and using it everywhere whenever needed

class AllUserData {
  String userFName;
  String userSurname;
  String userEmail;
  String userEmpId;
  String photoUrl;
  String qrData;
  String uid;
  int userType;

  AllUserData(this.userFName, this.userSurname, this.userEmail, this.userEmpId,
      this.photoUrl, this.qrData, this.uid, this.userType);

  AllUserData.formFireStore(Map<String, dynamic> data)
      : userFName = data['fname'],
        userSurname = data['surname'],
        userEmail = data['email'],
        userEmpId = data['empId'],
        photoUrl = data['url'],
        uid = data['uid'],
        userType = data['vendor'];

  AllUserData.fromJson(Map<String, dynamic> json) {
    userFName = json['fname'];
    userSurname = json['surname'];
    userEmail = json['email'];
    userEmpId = json['empId'];
    photoUrl = json['url'];
    qrData = json['qrData'];
    userType = json['vendor'];
  }

  Map<String, dynamic> toJson() => {
        'fname': userFName,
        'surname': userSurname,
        'email': userEmail,
        'empId': userEmpId,
        'url': photoUrl,
        'vendor': userType
      };
}
