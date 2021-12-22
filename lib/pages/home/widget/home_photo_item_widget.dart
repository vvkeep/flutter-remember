import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/utils/cache_utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomePhotoItemWidget extends StatefulWidget {
  final VoidCallback onTap;

  final FolderItemModel item;

  const HomePhotoItemWidget({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  _HomePhotoItemWidgetState createState() => _HomePhotoItemWidgetState();
}

class _HomePhotoItemWidgetState extends State<HomePhotoItemWidget> {
  File? file;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final temp = await CacheUtils.fileWithType(CacheType.PHTOT_IMGS, this.widget.item.name);
    setState(() {
      this.file = temp;
    });
  }

  Widget _loading() {
    if (file != null) {
      return Image.file(file!, fit: BoxFit.cover);
    } else {
      return CupertinoActivityIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.widget.onTap(),
      child: _loading(),
    );
  }
}
