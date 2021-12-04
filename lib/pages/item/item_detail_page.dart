import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/common/event_bus.dart';
import 'package:remember/manager/data_manager.dart';
import 'package:remember/model/img_model.dart';
import 'package:remember/model/item_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember/pages/item/widget/item_detail_choose_image_widget.dart';
import 'package:remember/pages/item/widget/item_detail_tag_widget.dart';
import 'package:remember/utils/storage_utils.dart';
import 'package:remember/widget/image_preview/photo_view_gallery_screen.dart';
import 'package:remember/widget/other/widget.dart';
import 'package:sqflite/sqflite.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key? key}) : super(key: key);

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final FocusNode _accountNode = FocusNode();
  final FocusNode _userNameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _payNode = FocusNode();
  final FocusNode _remarkNode = FocusNode();

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _payTextController = TextEditingController();
  final TextEditingController _remarkTextController = TextEditingController();

  final _picker = ImagePicker();

  List<RMPickImageItem> _pickedList = [RMPickImageItem(path: 'assets/imgs/add_img.png', type: PickImageMediaType.add)];
  List<CategoryModel> _categoryList = DataManager.shared.categoryList;
  List<TagModel> _tagList = DataManager.shared.tagList;
  late ItemModel itemModel;

  String get _chooseCategoryValueText {
    return this.itemModel.categoryId == -1
        ? '请选择账号分类'
        : this._categoryList.firstWhere((e) => e.id == this.itemModel.categoryId).title;
  }

  TextStyle get _chooseCategoryValueTextStyle {
    return this.itemModel.categoryId == -1 ? RMTextStyle.normalTextLight : RMTextStyle.normalTextDark;
  }

  TextStyle _chooseCategoryListTextStyle(int id) {
    return this.itemModel.categoryId == id ? RMTextStyle.normalTextDark : RMTextStyle.normalTextLight;
  }

  List<String> get _currentItemTagIds {
    if (ObjectUtil.isNotEmpty(this.itemModel.tagIds)) {
      return this.itemModel.tagIds!.split(",");
    } else {
      return [];
    }
  }

  bool get _isHaveNewImg {
    for (var item in _pickedList) {
      if (item.path == null) {
        return true;
      }
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    _initUI();
  }

  _initUI() async {
    ItemModel? item = Get.arguments as ItemModel?;
    List<RMPickImageItem> tempPickedList = [];

    if (item != null && ObjectUtil.isNotEmpty(item.imgs)) {
      List<String> imgNames = item.imgs!.split(",");

      for (var imgName in imgNames) {
        File file = await StorageUtils.localItemImgFile(imgName);
        RMPickImageItem pickItem = RMPickImageItem(type: PickImageMediaType.source, file: file, path: imgName);
        tempPickedList.add(pickItem);
      }
    }

    setState(() {
      if (item == null) {
        this.itemModel = ItemModel(id: -1, categoryId: -1, account: '', title: '');
      } else {
        this.itemModel = ItemModel.fromJson(item.toJson());
      }

      this._pickedList.addAll(tempPickedList);
    });
  }

  _choosePhoto(ImageSource source) async {
    XFile? file = await _picker.pickImage(source: source);
    if (file == null) {
      return;
    }

    RMPickImageItem item = RMPickImageItem(type: PickImageMediaType.source, file: File(file.path));
    var index = _pickedList.length - 1 > 0 ? _pickedList.length - 1 : 0;
    setState(() {
      _pickedList.insert(index, item);
    });
  }

  _save() async {
    if (ObjectUtil.isEmpty(_titleTextController.text)) {
      Fluttertoast.showToast(msg: '标题不能为空', gravity: ToastGravity.TOP);
      return;
    }

    if (ObjectUtil.isEmpty(_userNameTextController.text)) {
      Fluttertoast.showToast(msg: '用户名不能为空', gravity: ToastGravity.TOP);
      return;
    }

    itemModel.title = _titleTextController.text;
    itemModel.account = _userNameTextController.text;
    itemModel.password = _passwordTextController.text;
    itemModel.payPassword = _payTextController.text;
    itemModel.description = _remarkTextController.text;

    List<String> tempImgPaths = [];
    if (_isHaveNewImg) {
      for (var item in _pickedList) {
        if (item.type == PickImageMediaType.source) {
          final bytes = await item.file!.readAsBytes();
          String? path = await StorageUtils.saveItemImg(bytes);
          if (path != null) {
            tempImgPaths.add(path);
          }
        }
      }

      itemModel.imgs = tempImgPaths.join(",");
    }

    try {
      if (itemModel.id == -1) {
        await DataManager.shared.addItem(itemModel);
      } else {
        await DataManager.shared.updateItem(itemModel);
      }

      Fluttertoast.showToast(msg: '保存成功', gravity: ToastGravity.TOP);
      eventBus.fire(ItemEvent());
      eventBus.fire(CategoryListEvent());
      Get.back();
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError('item.title')) {
        Fluttertoast.showToast(msg: '此账号已存在，请修改分类名称', gravity: ToastGravity.TOP);
      } else {
        print(e.toString());
        Fluttertoast.showToast(msg: '数据库操作失败，请重试', gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: '操作失败，请重试', gravity: ToastGravity.TOP);
    }
  }

  Widget _buildInputField(String hitText, FocusNode focusNode, TextEditingController? controller) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: RMColors.divideColor,
            width: 1.0,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hitText,
          hintStyle: RMTextStyle.normalTextLight,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSectionTitleView(String title) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        color: RMColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: RMColors.primaryColor.withOpacity(0.3),
            offset: Offset(2.0, 2.0),
            blurRadius: 1,
          )
        ],
      ),
      child: Text(title, style: RMTextStyle.midTextWhite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RMColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("添加账号"),
        actions: [
          IconButton(
            icon: Icon(RMIcons.save),
            onPressed: () {
              this._save();
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          _accountNode.unfocus();
          _userNameNode.unfocus();
          _passwordNode.unfocus();
          _payNode.unfocus();
          _remarkNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: RMColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: RMColors.primaryColor.withOpacity(0.2),
                        offset: Offset(5.0, 5.0),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Text('账号分类', style: RMTextStyle.normalTextDark),
                      Spacer(),
                      PopupMenuButton(
                        onSelected: (int? categoryId) {
                          setState(() {
                            this.itemModel.categoryId = categoryId!;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return this
                              ._categoryList
                              .map(
                                (category) => PopupMenuItem(
                                  value: category.id,
                                  child: Text(
                                    category.title,
                                    style: _chooseCategoryListTextStyle(category.id),
                                  ),
                                ),
                              )
                              .toList();
                        },
                        child: Row(
                          children: [
                            Text(_chooseCategoryValueText, style: _chooseCategoryValueTextStyle),
                            Icon(RMIcons.arrow,
                                size: 15,
                                color:
                                    this.itemModel.categoryId == -1 ? RMColors.lightTextColor : RMColors.darkTextColor),
                            SizedBox(width: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _buildSectionTitleView("账号信息"),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: RMColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: RMColors.primaryColor.withOpacity(0.3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInputField("请输入账号标题", _accountNode, _titleTextController),
                      _buildInputField("请输入用户名", _userNameNode, _userNameTextController),
                      _buildInputField("请输入密码", _passwordNode, _passwordTextController),
                      _buildInputField("请输入支付密码", _payNode, _payTextController),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _buildSectionTitleView("附件图片"),
                ItemDetailChooseImageWidget(
                  itemList: this._pickedList,
                  callback: (item, index) {
                    if (item.type == PickImageMediaType.add) {
                      Get.bottomSheet(Container(
                        color: RMColors.white,
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text("相机"),
                              onTap: () {
                                Get.back();
                                this._choosePhoto(ImageSource.camera);
                              },
                            ),
                            Divider(height: 0, color: RMColors.divideColor),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text("相册"),
                              onTap: () {
                                Get.back();
                                this._choosePhoto(ImageSource.gallery);
                              },
                            ),
                            Divider(height: 0, color: RMColors.divideColor),
                            ListTile(
                              leading: Icon(Icons.cancel),
                              title: Text("退出"),
                              onTap: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ));
                    } else {
                      var files = _pickedList
                          .map((item) {
                            if (item.type != PickImageMediaType.add) {
                              return item.file;
                            } else {
                              return null;
                            }
                          })
                          .where((e) => e != null)
                          .map((e) => e!)
                          .toList();
                      var page = PhotoViewGalleryScreen(
                        files: files, //传入图片list
                        index: index,
                        heroTag: files[index].path, //传入当前点击的图片的index
                      );

                      Navigator.of(context).push(FadeRoute(page: page));
                    }
                  },
                ),
                SizedBox(height: 10),
                _buildSectionTitleView("选择标签"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: RMColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: RMColors.primaryColor.withOpacity(0.3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.8,
                    children: _tagList.map((tag) {
                      bool isSelected = this._currentItemTagIds.contains('${tag.id}');
                      return ItemDetailTagWidget(
                          tag: tag,
                          isSelected: isSelected,
                          onTap: () {
                            List<String> list = this._currentItemTagIds;
                            if (isSelected) {
                              list.removeWhere((e) => e == '${tag.id}');
                            } else {
                              list.add('${tag.id}');
                            }

                            setState(() {
                              this.itemModel.tagIds = list.join(",");
                            });
                          });
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                _buildSectionTitleView("添加备注"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: RMColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: RMColors.primaryColor.withOpacity(0.3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _remarkTextController,
                    focusNode: _remarkNode,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: '请输入此账号的备注',
                      hintStyle: RMTextStyle.normalTextLight,
                    ),
                    style: RMTextStyle.normalTextDark,
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
