import 'package:flutter/material.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/widgets/custom_text_widget_user_profile.dart';

class UserProfile extends StatefulWidget {
  final email;
  final fName;
  final surname;
  final empId;
  final url;

  const UserProfile(
      {Key key, this.email, this.empId, this.url, this.fName, this.surname})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenData.height * 0.03,
                width: 200,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                      height: 200,
                      width: 200,
                      child: widget.url == null || widget.url.isEmpty
                          ? Image(
                              image: NetworkImage('https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png'),
                              fit: BoxFit.fill,
                            )
                          : Image(
                              image: NetworkImage(widget.url.toString()),
                              fit: BoxFit.fill,
                            ))),
              SizedBox(
                height: 20.0,
              ),
              Text(
                widget.fName.toUpperCase() + ' ' + widget.surname.toUpperCase(),
                style: body30,
              ),
              SizedBox(
                height: screenData.height * 0.03,
                width: 200,
                child: Divider(
                  color: white,
                ),
              ),
              StreamBuilder(
                  stream: null,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextWidget(
                            color: lightRed,
                            title: 'JOB TITLE',
                            titleData: 'Software Trainee',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextWidget(
                            color: tealGreen,
                            title: 'EMPLOYEE ID',
                            titleData: widget.empId,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextWidget(
                            color: violet,
                            title: 'EMAIL',
                            titleData: widget.email,
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: screenData.height * 0.03,
                width: 200,
                child: Divider(
                  color: white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
