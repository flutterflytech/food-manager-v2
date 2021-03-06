//Put all your utils static methods here
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Toast for success and failure

class AppUtils {
  static void showToast(String message, Color alertColor, Color textColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: alertColor,
        textColor: textColor,
        fontSize: 16.0);
  }
}
