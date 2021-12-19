import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class HomePhotoFolderItemWidget extends StatelessWidget {
  final FolderModel folderModel;

  const HomePhotoFolderItemWidget({Key? key, required this.folderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: APPColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: APPColors.primaryColor.withOpacity(0.3),
            offset: Offset(5.0, 5.0),
            blurRadius: 3.0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: APPColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            height: 45,
            width: double.infinity,
            child: Text(
              folderModel.title,
              style: APPTextStyle.normalTextWhiteBold,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                '${folderModel.count}',
                style: APPTextStyle.largeTextPrimaryBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
