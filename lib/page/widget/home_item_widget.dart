import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/model/item_model.dart';

class HomeItemWidget extends StatelessWidget {
  final RMItemModel itemModel;
  const HomeItemWidget({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: RMColors.primaryColor.withOpacity(0.3),
            offset: Offset(1, 1),
            blurRadius: 0.5,
          )
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            width: 40,
            child:
                Text('${itemModel.id}', style: RMConstant.bigTextPrimaryBold),
          ),
          Container(
            color: Colors.green,
            width: 5,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(itemModel.title, style: RMConstant.normalTextDark),
                  Text('账号: ' + itemModel.account,
                      style: RMConstant.normalTextDark),
                  Text('密码: ' + itemModel.account,
                      style: RMConstant.normalTextDark)
                ],
              ),
            ),
          ),
          Image.asset(
            'assets/imgs/arrow.png',
            width: 9,
            height: 16,
          )
        ],
      ),
    );
  }
}
