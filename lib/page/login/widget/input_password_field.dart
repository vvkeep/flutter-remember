import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:flutter/services.dart';

class InputPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;

  InputPasswordField({Key? key, required this.controller, this.focusNode, required this.hintText}) : super(key: key);

  @override
  _InputPasswordFieldState createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.widget.controller,
      obscureText: !isVisible,
      focusNode: this.widget.focusNode,
      inputFormatters: [
        //只允许输入字母数字*
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9.]")),
        //限制长度
        LengthLimitingTextInputFormatter(20)
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: RMColors.mainBackgroundColor,
        hintText: this.widget.hintText,
        hintStyle: RMTextStyle.normalTextLight,
        suffixIcon: IconButton(
          onPressed: () {
            this.widget.focusNode?.unfocus();
            this.widget.focusNode?.canRequestFocus = false;
            Future.delayed(Duration(milliseconds: 100), () {
              this.widget.focusNode?.canRequestFocus = true;
            });
            setState(() {
              this.isVisible = !this.isVisible;
            });
          },
          iconSize: 20,
          icon: Icon(this.isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
