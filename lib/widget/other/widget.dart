import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';

import 'alert_widget.dart';

GetBar errorBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.red,
  );
}

GetBar successBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.blue,
  );
}

GetBar infoBar(String msg) {
  return GetBar(
    duration: Duration(seconds: 1),
    messageText: Text(msg, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.grey,
  );
}

class FadeRoute extends PageRouteBuilder {
  Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

appShowDialog(BuildContext context, String message, VoidCallback? confirmCallback,
    {String title = "温馨提示", String confirm = "确认"}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return AlertWidget(
        title: title,
        message: message,
        confirm: confirm,
        confirmCallback: () {
          if (confirmCallback != null) {
            confirmCallback();
          }
        },
      );
    },
    barrierColor: Colors.grey.withOpacity(.4),
    barrierDismissible: true,
    barrierLabel: "",
    transitionDuration: Duration(milliseconds: 125),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: child,
        ),
      );
    },
  );
}

Widget buildPopupMenuItem(IconData iconData, String title) {
  return Row(
    children: <Widget>[
      Icon(
        iconData,
        size: 22.0,
        color: APPColors.lightTextColor,
      ),
      Container(width: 12.0),
      Text(
        title,
        style: TextStyle(color: APPColors.lightTextColor),
      ),
    ],
  );
}

showLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return new Material(
        color: Colors.transparent,
        child: WillPopScope(
          onWillPop: () => new Future.value(false),
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

hiddenLoading(BuildContext context) {
  Navigator.pop(context); //销毁 loading
}

showToastError(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 20.0);
}

showToastSuccess(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 20.0);
}
