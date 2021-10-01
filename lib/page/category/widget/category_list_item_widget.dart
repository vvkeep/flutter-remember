import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/item_model.dart';

class CategoryListItemWidget extends StatelessWidget {
  final RMCategoryModel categoryModel;
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
                Text('${this.categoryModel.title}', style: RMTextStyle.normalTextDarkW500),
                Spacer(),
                Text('${this.categoryModel.count}', style: RMTextStyle.normalTextDark),
                SizedBox(width: 15),
                Icon(RMIcons.drag, color: RMColors.divideColor.withOpacity(0.5))
              ],
            ),
          ),
          Divider(height: 0, color: RMColors.darkDivideColor),
        ],
      ),
    );
  }
}
