import 'package:flutter/material.dart';
import 'package:food_manager_v2/views/register_page.dart';
import 'package:food_manager_v2/widgets/login_form_fields.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginForm(),
              SizedBox(
                height: screenData.height * 0.05,
              ),
              SizedBox(
                height: screenData.height * 0.07,
                width: screenData.width * 1.0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[700], Colors.blue[200]]),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: screenData.height * 0.02,
              ),
              Text("Don't have an account yet?"),
              SizedBox(
                height: screenData.height * 0.03,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text('Register here!',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
