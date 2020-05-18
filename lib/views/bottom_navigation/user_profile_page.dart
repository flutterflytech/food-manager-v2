import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/services/firebase_services/login_service.dart';
import 'package:food_manager_v2/widgets/custome_text_widget_user_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  final String user;

  const UserProfile({Key key, this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File _imageFile;
  String loggedInUserEmail = '';
  String loggedInUserFirstName = '';
  String loggedInUserLastName = '';
  String loggedInUserEmployeeId = '';

  @override
  void initState() {
    getLoggedInUserData();
    super.initState();
  }

  Future<void> _getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
    Navigator.pop(context);
  }

  _cropImage(File image) async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioY: 1.0, ratioX: 1.0));
    if (cropped != null) {
      setState(() {
        _imageFile = cropped;
      });
    }
  }

/*Future uploadImage() async{
    String fileName = (_imageFile.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
}*/

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenData.height * 0.03,
                width: 200,
              ),
              Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(200.0),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        height: 200,
                        width: 200,
                        child: _imageFile == null
                            ? Icon(
                                FontAwesomeIcons.solidUserCircle,
                                size: 190,
                              )
                            : Image.file(
                                _imageFile,
                                fit: BoxFit.fill,
                              ),
                      )),
                  Positioned(
                    right: 10.0,
                    bottom: 5.0,
                    child: GestureDetector(
                      onTap: _onButtonPressed,
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: lightBlue1),
                          margin: EdgeInsets.only(left: 51, top: 51),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            color: white,
                          )),
                    ),
                  ),
                ],
              ),
              Text(
                loggedInUserFirstName + ' ' + loggedInUserLastName,
                style: body40,
              ),
              SizedBox(
                height: screenData.height * 0.03,
                width: 200,
                child: Divider(
                  color: white,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
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
                            titleData: loggedInUserEmployeeId,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextWidget(
                            color: violet,
                            title: 'EMAIL',
                            titleData: loggedInUserEmail,
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

  getLoggedInUserData() async {
    LoginService loginService = LoginService();
    DocumentSnapshot snapshot = await loginService.loginUserData(widget.user);
    if (snapshot.data != null) {
      print(snapshot.data);
      setState(() {
        loggedInUserEmail = snapshot.data['email'];
        loggedInUserFirstName = snapshot.data['fname'];
        loggedInUserLastName = snapshot.data['surname'];
        loggedInUserEmployeeId = snapshot.data['empId'];
      });
    }
  }

  _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: Icon(
                      FontAwesomeIcons.cameraRetro,
                      size: 50,
                    ),
                    color: lightBlue1,
                    tooltip: 'Camera',
                  ),
                  IconButton(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: Icon(
                      FontAwesomeIcons.fileImage,
                      size: 50,
                    ),
                    color: lightBlue1,
                    tooltip: 'Gallery',
                  )
                ],
              ),
            ),
          );
        });
  }
}
