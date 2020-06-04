import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscure;
  final Function(String) onChanged;
  final Function(String) validator;

  const CustomTextFormField({
    Key key,
    this.hintText,
    this.obscure = false,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: darkBlue,
        obscureText: widget.obscure,

        decoration: InputDecoration(
            fillColor: white,
            filled: true,
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: lightBlue2, width: 2.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: darkBlue2, width: 2.0),
                borderRadius: BorderRadius.circular(50.0))
        ),
      ),
    );
  }
}
