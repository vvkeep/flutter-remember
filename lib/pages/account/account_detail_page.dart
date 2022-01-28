import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/img_model.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iron_box/pages/account/widget/account_detail_choose_image_widget.dart';
import 'package:iron_box/pages/account/widget/account_detail_tag_widget.dart';
import 'package:iron_box/utils/cache_utils.dart';
import 'package:iron_box/utils/permission_utils.dart';
import 'package:iron_box/widget/image_preview/photo_view_gallery_page.dart';
import 'package:iron_box/widget/other/widgets.dart';
import 'package:sqflite/sqflite.dart';

class AccountDetailPage extends StatefulWidget {
  AccountDetailPage({Key? key}) : super(key: key);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  AccountModel itemModel = AccountModel(id: -1, categoryId: -1, account: '', title: '');

  final FocusNode _accountNode = FocusNode();
  final FocusNode _userNameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _payNode = FocusNode();
  final FocusNode _remarkNode = FocusNode();

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _accountTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _payTextController = TextEditingController();
  final TextEditingController _descTextController = TextEditingController();

  final _picker = ImagePicker();

  List<RMPickImageItem> _pickedList = [RMPickImageItem(path: 'assets/imgs/add_img.png', type: PickImageMediaType.add)];
  List<CategoryModel> _categoryList = DataManager.shared.accountCategoryList;
  List<TagModel> _tagList = DataManager.shared.accountTagList;

  String get _chooseCategoryValueText {
    return this.itemModel.categoryId == -1
        ? '请选择账号分类'
        : this._categoryList.firstWhere((e) => e.id == this.itemModel.categoryId).title;
  }

  TextStyle get _chooseCategoryValueTextStyle {
    return this.itemModel.categoryId == -1 ? APPTextStyle.normalTextLight : APPTextStyle.normalTextDark;
  }

  TextStyle _chooseCategoryListTextStyle(int id) {
    return this.itemModel.categoryId == id ? APPTextStyle.normalTextDark : APPTextStyle.normalTextLight;
  }

  List<String> get _currentItemTagIds {
    if (ObjectUtil.isNotEmpty(this.itemModel.tagIds)) {
      return this.itemModel.tagIds!.split(",");
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    AccountModel? item = Get.arguments as AccountModel?;
    List<RMPickImageItem> tempPickedList = [];

    if (item != null && ObjectUtil.isNotEmpty(item.imgs)) {
      List<String> imgNames = item.imgs!.split(",");

      for (var imgName in imgNames) {
        final file = await CacheUtils.fileWithType(CacheType.ACCOUNT_IMGS, imgName);
        RMPickImageItem pickItem = RMPickImageItem(type: PickImageMediaType.source, file: file, path: imgName);
        tempPickedList.add(pickItem);
      }
    }

    if (ObjectUtil.isNotEmpty(item)) {
      itemModel = AccountModel.fromJson(item!.toJson());
    }

    if (ObjectUtil.isNotEmpty(Get.parameters["categoryId"])) {
      itemModel.categoryId = int.parse(Get.parameters["categoryId"]!);
    }

    setState(() {
      _titleTextController.text = this.itemModel.title;
      _accountTextController.text = this.itemModel.account;
      _passwordTextController.text = this.itemModel.password ?? "";
      _payTextController.text = this.itemModel.payPassword ?? "";
      _descTextController.text = this.itemModel.description ?? "";
      _pickedList.insertAll(0, tempPickedList);
    });
  }

  _choosePhoto(ImageSource source) async {
    bool granted = await PermissionUtils.checkPhotos() && await PermissionUtils.checkCamera();
    if (!granted) {
      return;
    }

    XFile? file = await _picker.pickImage(source: source);
    if (file == null) {
      return;
    }

    RMPickImageItem item = RMPickImageItem(type: PickImageMediaType.temp, file: File(file.path));
    var index = _pickedList.length - 1 > 0 ? _pickedList.length - 1 : 0;
    setState(() {
      _pickedList.insert(index, item);
    });
  }

  _save() async {
    if (itemModel.categoryId == -1) {
      Fluttertoast.showToast(msg: '分类不能为空', gravity: ToastGravity.TOP);
      return;
    }

    if (ObjectUtil.isEmpty(_titleTextController.text)) {
      Fluttertoast.showToast(msg: '标题不能为空', gravity: ToastGravity.TOP);
      return;
    }

    if (ObjectUtil.isEmpty(_accountTextController.text)) {
      Fluttertoast.showToast(msg: '用户名不能为空', gravity: ToastGravity.TOP);
      return;
    }

    itemModel.title = _titleTextController.text;
    itemModel.account = _accountTextController.text;
    itemModel.password = _passwordTextController.text;
    itemModel.payPassword = _payTextController.text;
    itemModel.description = _descTextController.text;

    List<String> tempImgPaths = [];
    final itemList = _pickedList.where((e) => e.type != PickImageMediaType.add).toList();
    for (var item in itemList) {
      if (item.type == PickImageMediaType.source) {
        tempImgPaths.add(item.path!);
      } else {
        String? path = await CacheUtils.save(CacheType.ACCOUNT_IMGS, item.file!);
        tempImgPaths.add(path!);
      }
    }

    itemModel.imgs = tempImgPaths.join(",");

    try {
      bool isSuccess = false;
      if (itemModel.id == -1) {
        isSuccess = await DataManager.shared.addAccount(itemModel);
      } else {
        isSuccess = await DataManager.shared.updateAccount(itemModel);
      }

      AppToast.showSuccess('${itemModel.id == -1 ? '添加' : "编辑"}成功');
      if (isSuccess) {
        eventBus.fire(ItemEvent());
        eventBus.fire(CategoryListEvent());
        Get.back();
      }
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError('account.title')) {
        AppToast.showError('此账号标题已存在，请修改标题');
      } else {
        print(e.toString());
        AppToast.showError('数据库操作失败，请重试');
      }
    } catch (e) {
      print(e.toString());
      AppToast.showError('操作失败，请重试');
    }
  }

  _deleteItem() async {
    await DataManager.shared.removeAccount(this.itemModel.id);
    eventBus.fire(CategoryListEvent());
    eventBus.fire(ItemEvent());
    Get.back();
  }

  Widget _buildInputField(String hitText, FocusNode focusNode, TextEditingController? controller) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: APPColors.divideColor,
            width: 1.0,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hitText,
          hintStyle: APPTextStyle.normalTextLight,
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
        color: APPColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: APPColors.primaryColor.withOpacity(0.3),
            offset: Offset(2.0, 2.0),
            blurRadius: 1,
          )
        ],
      ),
      child: Text(title, style: APPTextStyle.midTextWhite),
    );
  }

  Widget _buildDeleteButton() {
    return TextButton(
      onPressed: () {
        AppWidget.showDialog(context, "删除此账号后将无法恢复，确认该删除吗?", () {
          _deleteItem();
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: APPColors.warningColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text("删除", style: APPTextStyle.midTextWhite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text("添加账号", style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        elevation: 0, // 去掉Appbar底部阴影
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(APPIcons.save),
            color: Colors.white,
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
                    color: APPColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: APPColors.primaryColor.withOpacity(0.2),
                        offset: Offset(5.0, 5.0),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Text('账号分类', style: APPTextStyle.normalTextDark),
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
                            Icon(APPIcons.arrow,
                                size: 15,
                                color: this.itemModel.categoryId == -1
                                    ? APPColors.lightTextColor
                                    : APPColors.darkTextColor),
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
                    color: APPColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: APPColors.primaryColor.withOpacity(0.3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInputField("请输入账号标题", _accountNode, _titleTextController),
                      _buildInputField("请输入用户名", _userNameNode, _accountTextController),
                      _buildInputField("请输入密码", _passwordNode, _passwordTextController),
                      _buildInputField("请输入支付密码", _payNode, _payTextController),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _buildSectionTitleView("附件图片"),
                AccountDetailChooseImageWidget(
                  itemList: this._pickedList,
                  callback: (item, index) {
                    if (item.type == PickImageMediaType.add) {
                      Get.bottomSheet(Container(
                        color: APPColors.white,
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
                            Divider(height: 0, color: APPColors.divideColor),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text("相册"),
                              onTap: () {
                                Get.back();
                                this._choosePhoto(ImageSource.gallery);
                              },
                            ),
                            Divider(height: 0, color: APPColors.divideColor),
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
                      var page = PhotoViewGalleryPage(
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
                    color: APPColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: APPColors.primaryColor.withOpacity(0.3),
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
                    color: APPColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: APPColors.primaryColor.withOpacity(0.3),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _descTextController,
                    focusNode: _remarkNode,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: '请输入此账号的备注',
                      hintStyle: APPTextStyle.normalTextLight,
                    ),
                    style: APPTextStyle.normalTextDark,
                    maxLines: 5,
                  ),
                ),
                // SizedBox(height: 10),
                Visibility(visible: this.itemModel.id == -1 ? false : true, child: _buildDeleteButton()),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
