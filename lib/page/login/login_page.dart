import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:remember/config/style.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [RMColors.primaryColor, RMColors.secondPrimaryColor],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Get.mediaQuery.padding.top + 45),
            Text('欢迎使用记得', style: RMConstant.bigTextWhiteBold),
            SizedBox(height: 35 + 45),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: RMColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: Get.width - 50,
                  height: Get.width - 50,
                  child: Column(
                    children: [
                      SizedBox(height: 45 + 20),
                      Text("设置登录密码", style: RMConstant.midTextPrimaryW500),
                      SizedBox(height: 50),
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: RMColors.mainBackgroundColor,
                          hintText: '填写登录密码',
                          hintStyle: RMConstant.normalTextLight,
                        ),
                      ),
                      SizedBox(height: 50),
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: RMColors.mainBackgroundColor,
                          hintText: '确认登录密码',
                          hintStyle: RMConstant.normalTextLight,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: (Get.width - 50 - 90) / 2.0,
                  top: -45.0,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: RMColors.white,
                      borderRadius: BorderRadius.circular(90 / 2),
                      boxShadow: [
                        BoxShadow(
                          color: RMColors.primaryColor.withOpacity(0.3),
                          offset: Offset(0.0, 0.0),
                          blurRadius: 3.0,
                        )
                      ],
                    ),
                    child: Image.asset('assets/imgs/logo_icon.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {},
              child: Container(
                alignment: Alignment.center,
                width: Get.width - 50,
                height: 50,
                decoration: BoxDecoration(
                  color: RMColors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("确定", style: RMConstant.midTextPrimaryW500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
