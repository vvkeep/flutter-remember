import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class CategoryListItemWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryListItemWidget({Key? key, required this.categoryModel}) : super(key: key);

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
                Text('${this.categoryModel.title}', style: APPTextStyle.normalTextDarkW500),
                Spacer(),
                Text('${this.categoryModel.count}', style: APPTextStyle.normalTextDark),
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
