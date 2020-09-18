import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_manager_v2/constants/color_constants.dart';
import 'package:food_manager_v2/constants/style_constants.dart';
import 'package:food_manager_v2/widgets/edit_profile.dart';
import 'package:food_manager_v2/utils/app_utils.dart';
import 'package:food_manager_v2/widgets/custom_text_widget_user_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UserProfileWidget extends StatefulWidget {
  final String user;
  final String fName;
  final String userEmail;
  final String userEmpId;
  final String userSurname;
  final String photoUrl;

  const UserProfileWidget(
      {Key key,
      this.user,
      this.fName,
      this.userEmail,
      this.userEmpId,
      this.userSurname,
      this.photoUrl})
      : super(key: key);

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  File _imageFile;
  String imageUrl;

  @override
  void initState() {
    super.initState();
  }

// getting image from device or from camera

  Future<void> _getImage(ImageSource source) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
    Navigator.pop(context);
  }

// Crop fetched image
  _cropImage(File image) async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioY: 1.0, ratioX: 1.0));
    if (cropped != null) {
      setState(() {
        _imageFile = cropped;
        uploadFile();
      });
    }
  }

// Upload image file to fireStore Storage and get image URL
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    await uploadTask.onComplete;
    setState(() {
      imageUrl = url.toString();
    });
//    Show message on successful image upload
    AppUtils.showToast('Picture Uploaded', green, white);
//    Updating database with Image URL
    Firestore.instance
        .collection('account')
        .document(widget.user)
        .updateData({"url": imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
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
                        child: widget.photoUrl == null
                            ? Image(
                                image: NetworkImage(
                                    'https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png'),
                                fit: BoxFit.fill,
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.photoUrl,
                              ))),
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
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.fName.toUpperCase() +
                  ' ' +
                  widget.userSurname.toUpperCase(),
              style: body30,
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
                          titleData: widget.userEmpId,
                          user: widget.user,
                          empId: 'empId',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextWidget(
                          color: violet,
                          title: 'EMAIL',
                          titleData: widget.userEmail,
                          email: 'displayName',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                          userSurname: widget.userSurname,
                                          userFName: widget.fName,
                                          userEmpId: widget.userEmpId,
                                          userEmail: widget.userEmail,
                                          user: widget.user,
                                        )));
                          },
                          child: SizedBox(
                            height: screenData.height * 0.07,
                            width: screenData.width * 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [darkBlue2, lightBlue2]),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                "Edit Profile",
                                style: body15,
                              )),
                            ),
                          ),
                        ),
                      )
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
    );
  }


//  Button action to select image from camera or from storage
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
