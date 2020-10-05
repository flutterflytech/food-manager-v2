import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends StatefulWidget {
  final name;
  final url;

  const GoogleLogin({Key key, this.name, this.url}) : super(key: key);
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('welcome ' + widget.name),
              Image.network(widget.url),
              RaisedButton(
                onPressed: () {
                  _googleSignIn.disconnect();
                  Navigator.pop(context);
                },
                child: Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
