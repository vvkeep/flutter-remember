import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/item_model.dart';

class ItemDetailTagWidget extends StatefulWidget {
  final TagModel tag;

  final bool isSelected;

  final VoidCallback onTap;

  ItemDetailTagWidget({Key? key, required this.tag, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  _ItemDetailTagWidgetState createState() => _ItemDetailTagWidgetState();
}

class _ItemDetailTagWidgetState extends State<ItemDetailTagWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: this.widget.isSelected ? APPColors.primaryColor : null,
          border: this.widget.isSelected
              ? null
              : Border.all(
                  color: APPColors.primaryColor.withOpacity(0.5),
                  width: 1,
                ),
        ),
        alignment: Alignment.center,
        child: Text(this.widget.tag.title,
            style: this.widget.isSelected ? APPTextStyle.normalTextWhite : APPTextStyle.normalTextLight),
      ),
    );
  }
}
