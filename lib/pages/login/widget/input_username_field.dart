import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:flutter/services.dart';

class InputUsernameField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;

  InputUsernameField({Key? key, required this.controller, this.focusNode, required this.hintText}) : super(key: key);

  @override
  _InputUsernameFieldState createState() => _InputUsernameFieldState();
}

class _InputUsernameFieldState extends State<InputUsernameField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.widget.controller,
      focusNode: this.widget.focusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: APPColors.mainBackgroundColor,
        hintText: this.widget.hintText,
        hintStyle: APPTextStyle.normalTextLight,
      ),
    );
  }
}
