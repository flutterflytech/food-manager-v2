import 'package:firebase_auth/firebase_auth.dart';

class LogoutService{
  logoutService()async{
    return await FirebaseAuth.instance.signOut();
  }
}