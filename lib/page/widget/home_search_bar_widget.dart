import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';

class HomeSearchBarWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeSearchBarWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height,
            child: Container(color: RMColors.primaryColor)),
        InkWell(
          onTap: this.onPressed,
          child: Container(
            width: double.infinity,
            height: 45,
            color: RMColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: RMColors.darkTextColor),
                    Text('请输入账号或标题', style: RMConstant.normalTextDark)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
