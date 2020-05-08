import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

// auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String empId, String firstName, String lastName, int vendor) async {
    try {
//      print(email+'@'+password+'@'+empId+'@'+firstName+'@'+lastName+'@');
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Firestore.instance.collection('account').document(user.uid).setData({
        "email": email,
        "empId": empId,
        "fname": firstName,
        "surname": lastName,
        "uid": user.uid,
        "vendor": vendor,
      });
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
