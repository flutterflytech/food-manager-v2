// User Model

class User {
  final String uid;

  User({this.uid});
}

// user model for receiving data and using it everywhere whenever needed

class UserData {
  final String userFName;
  final String userSurname;
  final String userEmail;
  final String userEmpId;
  final String photoUrl;
  final int userType;

  UserData(this.userFName, this.userSurname, this.userEmail, this.userEmpId,
      this.photoUrl, this.userType);
}
