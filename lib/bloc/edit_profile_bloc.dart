import 'dart:async';

import 'package:rxdart/rxdart.dart';

class EditProfileBLoC{
  final firstNameStreamController = BehaviorSubject<String>();
  final lastNameStreamController = BehaviorSubject<String>();
  firstName(String fname){
    firstNameStreamController.sink.add(fname);
  }
  lastName(String lname){
    lastNameStreamController.sink.add(lname);
  }
  void dispose(){
    firstNameStreamController.close();
    lastNameStreamController.close();
}
}