import 'package:firebase_auth/firebase_auth.dart';

class LogoutService{

  Future logoutService() async{
     await FirebaseAuth.instance.signOut();
     return true;
  }
}