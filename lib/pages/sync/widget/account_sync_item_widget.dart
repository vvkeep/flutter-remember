import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/models.dart';

class AccountSyncItemWidget extends StatelessWidget {
  final AccountSyncItemUIModel model;
  const AccountSyncItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: APPColors.white, borderRadius: BorderRadius.circular(5), boxShadow: [
        BoxShadow(
          color: APPColors.secondPrimaryColor.withOpacity(0.3),
          offset: Offset.zero,
          blurRadius: 3,
        ),
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgs/${model.image}'),
          SizedBox(height: 10),
          Text(model.title, style: APPTextStyle.midTextPrimaryW500)
        ],
      ),
    );
  }
}
