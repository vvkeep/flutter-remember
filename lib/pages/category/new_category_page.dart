import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/item_model.dart';
import 'package:sqflite/sqflite.dart';

class NewCategoryPage extends StatefulWidget {
  NewCategoryPage({Key? key}) : super(key: key);

  @override
  _NewCategoryPageState createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  final FocusNode focusNode = FocusNode();
  final nameController = TextEditingController();
  VoidCallback? categoryChangedCallback;
  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    Map<String, Object> args = Get.arguments as Map<String, Object>;
    categoryChangedCallback = args["callback"] as VoidCallback?;
    categoryModel = args["category"] as CategoryModel?;
    nameController.text = categoryModel?.title ?? "";

    return Scaffold(
      backgroundColor: APPColors.white,
      appBar: AppBar(
        title: Text('添加分类', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
                height: 75,
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
                        color: APPColors.primaryColor,
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
                    color: APPColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("保存", style: APPTextStyle.midTextWhite),
                ),
                onPressed: () async {
                  String name = nameController.text;
                  if (name.isEmpty) {
                    Fluttertoast.showToast(msg: '请输入分类名称', gravity: ToastGravity.TOP);
                    return;
                  }

                  focusNode.unfocus();
                  try {
                    if (this.categoryModel != null) {
                      categoryModel!.title = name;
                      await DataManager.shared.updateCategory(categoryModel!);
                      Fluttertoast.showToast(msg: '编辑成功', gravity: ToastGravity.TOP);
                    } else {
                      await DataManager.shared.addCategory(name, 0);
                      Fluttertoast.showToast(msg: '添加成功', gravity: ToastGravity.TOP);
                    }
                    categoryChangedCallback!();
                    Get.back();
                  } on DatabaseException catch (e) {
                    if (e.isUniqueConstraintError('category.title')) {
                      Fluttertoast.showToast(msg: '此分类已存在，请修改分类名称', gravity: ToastGravity.TOP);
                    } else {
                      Fluttertoast.showToast(msg: '数据库操作失败，请重试', gravity: ToastGravity.TOP);
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: '操作失败，请重试', gravity: ToastGravity.TOP);
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
