import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/item_model.dart';

class HomeItemDetailTagWidget extends StatefulWidget {
  final TagModel tag;

  final bool isSelected;

  final VoidCallback onTap;

  HomeItemDetailTagWidget({Key? key, required this.tag, required this.isSelected, required this.onTap})
      : super(key: key);

  @override
  _HomeItemDetailTagWidgetState createState() => _HomeItemDetailTagWidgetState();
}

class _HomeItemDetailTagWidgetState extends State<HomeItemDetailTagWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: this.widget.isSelected ? RMColors.primaryColor : null,
          border: this.widget.isSelected
              ? null
              : Border.all(
                  color: RMColors.primaryColor.withOpacity(0.5),
                  width: 1,
                ),
        ),
        alignment: Alignment.center,
        child: Text(this.widget.tag.title,
            style: this.widget.isSelected ? RMTextStyle.normalTextWhite : RMTextStyle.normalTextLight),
      ),
    );
  }
}
