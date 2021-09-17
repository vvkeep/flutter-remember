import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [RMColors.primaryColor, RMColors.secondPrimaryColor],
          ),
        ),
        child: null,
      ),
    );
  }
}
