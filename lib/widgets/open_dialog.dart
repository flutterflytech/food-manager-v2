import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenDialog {
  openDialog(BuildContext context) {
    return showDialog(
        context: context,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            height: 200,
            width: 200,
            child: FlareActor(
              // "assets/flare/scan_qr.flr",
              "assets/flare/Success Check.flr",
              // "assets/flare/failure.flr",
              animation: "Untitled",
              fit: BoxFit.cover,
              color: Colors.blue[900],
            )),
          ),
        );
  }
}
