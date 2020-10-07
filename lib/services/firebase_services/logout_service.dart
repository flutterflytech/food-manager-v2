import 'package:firebase_auth/firebase_auth.dart';

class LogoutService{

  Future logoutService() async{
     return await FirebaseAuth.instance.signOut().catchError((onError){
       print("================"+onError+"=================");
     });
  }
}