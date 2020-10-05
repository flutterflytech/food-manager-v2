import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

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

//  register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String empId,
      String firstName,
      String lastName,
      int userType,
      String url) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      Firestore.instance.collection('account').document(user.uid).setData({
        "userEmail": email,
        "userEmpId": empId,
        "userFName": firstName,
        "userSurname": lastName,
        "uid": user.uid,
        "userType": userType,
        "url": url,
        "recentBookings":[]
      });
      return _userFromFirebaseUser(user);
    } catch (error) {
      return error;
    }
  }

//  signIn with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      return error;
    }
  }
}
