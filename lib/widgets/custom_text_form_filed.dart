import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String validator;
  final bool obscure;


  const CustomTextFormField({Key key, this.hintText,this.validator,this.obscure=false}) : super(key: key);
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() {

          });
        },
        cursorColor: Colors.blue[900],
        obscureText: widget.obscure,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
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
    );
  }
}
