import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/helper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NewCategoryPage extends StatefulWidget {
  NewCategoryPage({Key? key}) : super(key: key);

  @override
  _NewCategoryPageState createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  final FocusNode focusNode = FocusNode();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.white,
      appBar: AppBar(
        title: Text('添加分类'),
      ),
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                width: Get.width - 50,
                height: 85,
                child: TextField(
                  controller: nameController,
                  focusNode: this.focusNode,
                  maxLength: 15,
                  decoration: InputDecoration(
                    hintText: "请输入分类名称",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      textBaseline: TextBaseline.ideographic,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: RMColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: RMColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("保存", style: RMTextStyle.midTextWhite),
                ),
                onPressed: () async {
                  String name = nameController.text;
                  if (name.isEmpty) {
                    Fluttertoast.showToast(msg: '请输入分类名称', gravity: ToastGravity.TOP);
                    return;
                  }

                  focusNode.unfocus();
                  try {
                    await DatabaseHelper.shared.insertCategory(name);
                    Fluttertoast.showToast(msg: '添加成功', gravity: ToastGravity.TOP);
                    Get.back();
                  } on DatabaseException catch (e) {
                    if (e.isUniqueConstraintError('category.title')) {
                      Fluttertoast.showToast(msg: '此分类已存在，请修改分类名称', gravity: ToastGravity.TOP);
                    } else {
                      Fluttertoast.showToast(msg: '数据库插入失败，请重试', gravity: ToastGravity.TOP);
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: '添加失败，请重试', gravity: ToastGravity.TOP);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}