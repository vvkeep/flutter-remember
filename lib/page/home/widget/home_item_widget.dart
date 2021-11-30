import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/item_model.dart';

class HomeItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  const HomeItemWidget({Key? key, required this.itemModel}) : super(key: key);

  Widget itemView(String key, String value, VoidCallback? onPressed) {
    return Row(
      children: [
        Text(key, style: RMTextStyle.normalTextDark),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: RMTextStyle.normalTextDark,
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
              RMIcons.COPY,
              color: RMColors.primaryColor,
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
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: RMColors.primaryColor.withOpacity(0.3),
                  offset: Offset(1, 1),
                  blurRadius: 0.5,
                )
              ],
            ),
            alignment: Alignment.center,
            width: 40,
            child: Text('${itemModel.id}', style: RMTextStyle.biggerTextPrimaryBold),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(itemModel.title, style: RMTextStyle.normalTextDarkW500),
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
          Icon(RMIcons.arrow, size: 15),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
