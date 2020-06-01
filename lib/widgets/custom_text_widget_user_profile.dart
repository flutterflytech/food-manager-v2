import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_manager_v2/constants/style_constants.dart';

class CustomTextWidget extends StatefulWidget {
  final title;
  final titleData;
  final color;
  final user;
  final email;
  final empId;

  const CustomTextWidget({Key key, this.title, this.titleData, this.color, this.user, this.email, this.empId})
      : super(key: key);

  @override
  _CustomTextWidgetState createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Container(
      width: screenData.width * 1.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: widget.color),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: body15,
                ),
                Text(
                  widget.titleData,
                  style: body30White,
                ),
              ],
            ),

          ],

        ),
      ),
    );
  }

}
