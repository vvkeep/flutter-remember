import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/model/item_model.dart';

class HomeItemWidget extends StatelessWidget {
  final RMCategoryModel categoryModel;

  const HomeItemWidget({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: RMColors.itemBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: RMColors.primaryColor.withOpacity(0.3),
              offset: Offset(5.0, 5.0),
              blurRadius: 3.0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: RMColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            height: 45,
            width: double.infinity,
            child: Text(
              categoryModel.title,
              style: RMConstant.normalTextWhiteBold,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                '${categoryModel.count}',
                style: RMConstant.largeTextPrimaryBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
