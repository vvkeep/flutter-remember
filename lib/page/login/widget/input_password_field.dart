import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';

class InputPasswordField extends StatefulWidget {
  final String hintText;

  InputPasswordField({Key? key, required this.hintText}) : super(key: key);

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
      obscureText: isVisible,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: RMColors.mainBackgroundColor,
        hintText: this.widget.hintText,
        hintStyle: RMConstant.normalTextLight,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              this.isVisible = !this.isVisible;
            });
          },
          icon: Icon(this.isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
