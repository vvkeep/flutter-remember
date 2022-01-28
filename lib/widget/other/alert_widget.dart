import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlertWidget extends Dialog {
  String title = '';
  String message = '';
  String confirm = '确定';
  VoidCallback? confirmCallback;
  VoidCallback? cancelCallback;

  AlertWidget(
      {required this.title, required this.message, this.cancelCallback, this.confirmCallback, required this.confirm});

  @override
  Widget build(BuildContext context) {
    return Material(
//        type: MaterialType.transparency,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(message),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: TextButton(
                            child: Text('取消'),
                            onPressed: cancelCallback == null
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : cancelCallback,
                          ),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1, color: Color(0xffEFEFF4))),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Text(
                          confirm,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          if (confirmCallback != null) {
                            confirmCallback!();
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
