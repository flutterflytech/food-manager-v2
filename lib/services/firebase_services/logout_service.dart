import 'package:firebase_auth/firebase_auth.dart';

class LogoutService{

  Future logoutService() async{
    try{
      return await FirebaseAuth.instance.signOut();
    }catch(e){
      print("====================> Logout Error <=================="+e.toString());
    }

  }
}