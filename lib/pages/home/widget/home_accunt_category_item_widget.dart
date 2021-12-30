import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class HomeAccountCategoryItemWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const HomeAccountCategoryItemWidget({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Text(categoryModel.title, style: APPTextStyle.normalTextDark),
                  Expanded(child: SizedBox()),
                  Text('${categoryModel.count}', style: APPTextStyle.normalTextDark),
                  SizedBox(width: 10),
                  Icon(APPIcons.arrow, size: 15, color: APPColors.lightTextColor),
                  SizedBox(width: 10)
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Divider(
                height: 0.0,
                indent: 15,
                endIndent: 10,
              ),
            )
          ],
        ));
  }
}
