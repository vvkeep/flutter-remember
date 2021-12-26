import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/models.dart';
import 'package:iron_box/utils/cache_utils.dart';

class HomePhotoItemWidget extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  final PhotoItemUIModel item;

  const HomePhotoItemWidget({Key? key, required this.item, required this.onTap, required this.onLongPress})
      : super(key: key);

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
    print("name:${this.widget.item.itemModel.name}");
    final temp = await CacheUtils.fileWithType(CacheType.PHTOT_IMGS, this.widget.item.itemModel.name);
    setState(() {
      this.file = temp;
    });
  }

  Widget _loading() {
    if (file != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(file!, fit: BoxFit.cover),
          Visibility(
            visible: this.widget.item.isEditMode,
            child: Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                child: Icon(
                  this.widget.item.isSelected ? APPIcons.chooseSelected : APPIcons.choose,
                  color: APPColors.white,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return CupertinoActivityIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.widget.onTap(),
      onLongPress: () => this.widget.onLongPress(),
      child: _loading(),
    );
  }
}
