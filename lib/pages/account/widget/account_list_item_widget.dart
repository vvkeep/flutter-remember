import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/account_model.dart';

class AccountListItemWidget extends StatelessWidget {
  final AccountModel itemModel;
  final int index;
  const AccountListItemWidget({Key? key, required this.itemModel, required this.index}) : super(key: key);

  Widget itemView(String key, String value, VoidCallback? onPressed) {
    return Row(
      children: [
        Text(key, style: APPTextStyle.normalTextDark),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: APPTextStyle.normalTextDark,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 25,
          height: 25,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            icon: Icon(
              APPIcons.copy,
              color: APPColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }

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
            color: APPColors.primaryColor.withOpacity(0.3),
            offset: Offset(1, 1),
            blurRadius: 0.5,
          )
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: APPColors.primaryColor.withOpacity(0.3),
                  offset: Offset(1, 1),
                  blurRadius: 0.5,
                )
              ],
            ),
            alignment: Alignment.center,
            width: 40,
            child: Text('${index + 1}', style: APPTextStyle.biggerTextPrimaryBold),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(itemModel.title, style: APPTextStyle.normalTextDarkW500),
                  itemView('账号:', itemModel.account, () {
                    Clipboard.setData(new ClipboardData(text: itemModel.account));
                    Fluttertoast.showToast(msg: '账号复制成功', gravity: ToastGravity.TOP);
                  }),
                  itemView('密码:', itemModel.password ?? "", () {
                    Clipboard.setData(new ClipboardData(text: itemModel.password));
                    Fluttertoast.showToast(msg: '密码复制成功', gravity: ToastGravity.TOP);
                  }),
                ],
              ),
            ),
          ),
          Icon(APPIcons.arrow, size: 15),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
