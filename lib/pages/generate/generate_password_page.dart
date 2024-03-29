import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/utils/password_utils.dart';

class GeneratePasswordPage extends StatefulWidget {
  GeneratePasswordPage({Key? key}) : super(key: key);

  @override
  _GeneratePasswordPageState createState() => _GeneratePasswordPageState();
}

class _GeneratePasswordPageState extends State<GeneratePasswordPage> {
  double _passwordLength = 16;
  bool _isLetterLowerCase = true;
  bool _isLetterUpperCase = true;
  bool _isSpecial = true;
  bool _isNumber = true;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("生成密码", style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
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
                        color: APPColors.primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: APPColors.primaryColor,
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
                ),
                onPressed: () => _generateBtnAction(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: APPColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("重新生成", style: APPTextStyle.midTextWhite),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1, 1)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () => _copyBtnAction(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: APPColors.primaryColor, width: 1.0)),
                  child: Text("复制密码", style: APPTextStyle.midTextPrimaryW500),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 40,
                child: Text("选项", style: APPTextStyle.midTextPrimaryW500),
              ),
              Divider(
                height: 0,
                color: APPColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      "长度",
                      style: APPTextStyle.normalTextDarkW500,
                    ),
                    Expanded(
                      child: Slider(
                        label: "${_passwordLength.toInt()}",
                        divisions: 10,
                        value: _passwordLength,
                        activeColor: APPColors.primaryColor,
                        min: 10,
                        max: 20,
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
                color: APPColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "小写字母",
                      style: APPTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: APPColors.primaryColor,
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
                color: APPColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "大写字母",
                      style: APPTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: APPColors.primaryColor,
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
                color: APPColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "特殊符号",
                      style: APPTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: APPColors.primaryColor,
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
                color: APPColors.darkDivideColor,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "数字",
                      style: APPTextStyle.normalTextDarkW500,
                    ),
                    CupertinoSwitch(
                      activeColor: APPColors.primaryColor,
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
        PasswordUtils.generate(_isLetterLowerCase, _isLetterUpperCase, _isNumber, _isSpecial, _passwordLength.toInt());
    _controller.text = password;
  }
}
