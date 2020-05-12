import 'package:flutter/material.dart';

class CustomeTextWidget extends StatefulWidget {
  final title;
  final titleData;

  const CustomeTextWidget({Key key, this.title, this.titleData})
      : super(key: key);

  @override
  _CustomeTextWidgetState createState() => _CustomeTextWidgetState();
}

class _CustomeTextWidgetState extends State<CustomeTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.titleData,
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}
