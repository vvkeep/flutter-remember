import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class AlbumListItemWidget extends StatelessWidget {
  final FolderModel folderModel;
  const AlbumListItemWidget({Key? key, required this.folderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 55,
            child: Row(
              children: [
                Text('${this.folderModel.title}', style: APPTextStyle.normalTextDark),
                Spacer(),
                Text('${this.folderModel.count}', style: APPTextStyle.normalTextDark),
                SizedBox(width: 15),
                Icon(APPIcons.drag, color: APPColors.divideColor)
              ],
            ),
          ),
          Divider(height: 0, color: APPColors.darkDivideColor),
        ],
      ),
    );
  }
}
