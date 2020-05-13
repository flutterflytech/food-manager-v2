import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/style_constants.dart';

class CustomTextWidget extends StatefulWidget {
  final title;
  final titleData;

  const CustomTextWidget({Key key, this.title, this.titleData})
      : super(key: key);

  @override
  _CustomTextWidgetState createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: body20,
          ),
          Text(
            widget.titleData,
            style: body40,
          ),
        ],
      ),
    );
  }
}
