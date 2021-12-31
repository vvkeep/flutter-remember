import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'alert_widget.dart';

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

class AppWidget {
  static showDialog(BuildContext context, String message, VoidCallback? confirmCallback,
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

  static Widget buildPopupMenuItem(IconData iconData, String title) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 22.0,
          color: APPColors.darkTextColor,
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: APPColors.darkTextColor),
        ),
      ],
    );
  }
}

class AppLoading {
  static show(BuildContext context) {
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

  static hidden(BuildContext context) {
    Navigator.pop(context); //销毁 loading
  }
}

class AppToast {
  static showError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showSuccess(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
