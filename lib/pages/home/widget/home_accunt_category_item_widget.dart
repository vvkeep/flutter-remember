import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class HomeAccountCategoryItemWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const HomeAccountCategoryItemWidget({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
          color: APPColors.white, border: Border(bottom: BorderSide(color: APPColors.divideColor, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          Text(categoryModel.title, style: APPTextStyle.normalTextDarkW500),
          Expanded(child: SizedBox()),
          Text('${categoryModel.count}', style: APPTextStyle.normalTextDarkW500),
          SizedBox(width: 10),
          Icon(APPIcons.arrow, size: 15),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
