// User Model for saving Logged In user Uid

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
  // String qrData;
  String uid;
  int userType;

  AllUserData(this.userFName, this.userSurname, this.userEmail, this.userEmpId,
      this.photoUrl, this.uid, this.userType);

  AllUserData.formFireStore(Map<String, dynamic> data)
      : userFName = data['userFName'],
        userSurname = data['userSurname'],
        userEmail = data['userEmail'],
        userEmpId = data['userEmpId'],
        photoUrl = data['url'],
        uid = data['uid'],
        userType = data['userType'];

  AllUserData.fromJson(Map<String, dynamic> json) {
    userFName = json['userFName'];
    userSurname = json['userSurname'];
    userEmail = json['userEmail'];
    userEmpId = json['userEmpId'];
    photoUrl = json['url'];
    // qrData = json['qrData'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() => {
        'userFName': userFName,
        'userSurname': userSurname,
        'userEmail': userEmail,
        'userEmpId': userEmpId,
        'url': photoUrl,
        'userType': userType
      };
}
