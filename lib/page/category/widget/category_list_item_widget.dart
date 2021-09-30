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
      child: Row(
        children: [
          Text('$this.categoryModel.title}', style: RMTextStyle.normalTextDark),
          Spacer(),
          Text('${this.categoryModel.count}', style: RMTextStyle.normalTextDark),
        ],
      ),
    );
  }
}
