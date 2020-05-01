import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.network('https://images-na.ssl-images-amazon.com/images/I/71-JgmazjTL.png',height: 200,width: 200,)
      ),
    );
  }

}
