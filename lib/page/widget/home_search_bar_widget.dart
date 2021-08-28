import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';

class HomeSearchBarWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeSearchBarWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        color: RMColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.search), Text('请输入账号或标题')],
            ),
          ),
        ),
      ),
    );
  }
}
