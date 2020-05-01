import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_manager_v2/services/auth.dart';
import 'package:food_manager_v2/views/login_page.dart';
import 'package:food_manager_v2/widgets/login_form_fields.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  String empId = '';
  int vendor = 0;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email.';
    } else {
      return null;
    }

  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters.';
    } else {
      return null;
    }
  }

  String firstNameValidator(String value){
    if (value.length == 0){
      return 'Please enter your first name';
    }else{
      return null;
    }
  }

  String lastNameValidator(String value){
    if (value.length == 0){
      return 'Please enter your last name';
    }else{
      return null;
    }
  }

  String employeeIdValidator(String value) {
    if (value.length != 6) {
      return 'This is not a valid employee ID';
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: firstNameValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value){
                        setState(()=>firstName=value);
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'First Name*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    TextFormField(
                      validator: lastNameValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value){
                        setState(()=>lastName=value);
                      },
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Last Name*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    TextFormField(
                      validator: employeeIdValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value){
                        setState(()=>empId=value);
                      },
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'EmployeeId*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    TextFormField(
                      validator: emailValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value){
                        setState(()=>empId=value);
                      },
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    TextFormField(
                      validator: pwdValidator,
                      cursorColor: Colors.blue[900],
                      onChanged: (value){
                        setState(()=>password=value);
                      },
                      obscureText: true,
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    /*TextFormField(
                      obscureText: true,
                      validator: pwdValidator,
                      cursorColor: Colors.blue[900],
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Conform Password*',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(50.0))),
                    ),*/
                    SizedBox(
                      height: screenData.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: ()async{
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, empId, firstName, lastName);
                        }
                      },
                      child: SizedBox(
                        height: screenData.height * 0.07,
                        width: screenData.width * 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue[700], Colors.blue[200]]),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenData.height * 0.02,
                    ),
                    Text("Already have an account?"),
                    SizedBox(
                      height: screenData.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => LogInPage()));
                      },
                      child: Text('Login here!',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
