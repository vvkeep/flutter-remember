import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/utils/password_utils.dart';
import 'package:remember/widget/other/widget.dart';

class GeneratePasswordPage extends StatefulWidget {
  GeneratePasswordPage({Key? key}) : super(key: key);

  @override
  _GeneratePasswordPageState createState() => _GeneratePasswordPageState();
}

class _GeneratePasswordPageState extends State<GeneratePasswordPage> {
  double _passwordLength = 0;
  bool _isLetterLowerCase = true;
  bool _isLetterUpperCase = true;
  bool _isSpecial = true;
  bool _isNumber = true;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("密码生成"),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                child: TextField(
                  controller: _controller,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: RMColors.primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: RMColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1, 1)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all(RMColors.lightTextColor),
                ),
                onPressed: () => _generateBtnAction(),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "重新生成",
                    style: RMTextStyle.bigTextWhiteW500,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1, 1)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all(RMColors.lightTextColor),
                ),
                onPressed: () => _copyBtnAction(),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "复制密码",
                    style: RMTextStyle.bigTextWhiteW500,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 40,
                child: Text("选项", style: RMTextStyle.midTextPrimaryW500),
              ),
              Divider(
                height: 0,
                color: RMColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      "长度",
                      style: RMTextStyle.normalTextDarkW500,
                    ),
                    Expanded(
                      child: Slider(
                        label: "$_passwordLength",
                        divisions: 10,
                        value: _passwordLength,
                        min: 6,
                        max: 46,
                        onChanged: (value) {
                          setState(() {
                            _passwordLength = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: RMColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "小写字母",
                      style: RMTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: RMColors.primaryColor,
                      value: _isLetterLowerCase,
                      onChanged: (bool value) {
                        setState(() {
                          _isLetterLowerCase = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: RMColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "大写字母",
                      style: RMTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: RMColors.primaryColor,
                      value: _isLetterUpperCase,
                      onChanged: (bool value) {
                        setState(() {
                          _isLetterUpperCase = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: RMColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "特殊符号",
                      style: RMTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: RMColors.primaryColor,
                      value: _isSpecial,
                      onChanged: (bool value) {
                        setState(() {
                          _isSpecial = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: RMColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "数字",
                      style: RMTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: RMColors.primaryColor,
                      value: _isNumber,
                      onChanged: (bool value) {
                        setState(() {
                          _isNumber = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _copyBtnAction() {
    final data = ClipboardData(text: _controller.text);
    Clipboard.setData(data);
    Fluttertoast.showToast(msg: "复制成功", gravity: ToastGravity.TOP);
  }

  _generateBtnAction() {
    final password =
        PasswordUtils.generate(_isLetterLowerCase, _isLetterUpperCase, _isNumber, _isSpecial, _passwordLength as Int);
    _controller.text = password;
  }
}
