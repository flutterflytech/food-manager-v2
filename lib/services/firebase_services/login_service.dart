import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService{

  loginUserData(String user) async{
    return await Firestore.instance
        .collection('account')
        .document(user)
        .get();
  }
}