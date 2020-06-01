// User Model

class User {
  final String uid;

  User({this.uid});
}

// user model for receiving data and using it everywhere whenever needed

class AllUserData {
  final String userFName;
  final String userSurname;
  final String userEmail;
  final String userEmpId;
  final String photoUrl;
  final int userType;

  AllUserData(this.userFName, this.userSurname, this.userEmail, this.userEmpId,
      this.photoUrl, this.userType);

  AllUserData.formFireStore(Map<String, dynamic> data)
      : userFName = data['fname'],
        userSurname = data['surname'],
        userEmail = data['email'],
        userEmpId = data['empId'],
        photoUrl = data['url'],
        userType = data['vendor'];

  Map<String, dynamic> toJson() =>
      {
        'fname': userFName,
        'surname': userSurname,
        'email': userEmail,
        'empId': userEmpId,
        'url': photoUrl,
        'vendor': userType
      };


}

