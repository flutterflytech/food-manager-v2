import 'package:cloud_firestore/cloud_firestore.dart';

// Login Services class for getting logged in user

class LoginService{
  loginUserData(String user) async{
    return await Firestore.instance
        .collection('account')
        .document(user)
        .get();
  }
}