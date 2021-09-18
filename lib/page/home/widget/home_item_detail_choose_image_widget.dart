import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';

class HomeItemDetailChooseImageWidget extends StatefulWidget {
  const HomeItemDetailChooseImageWidget({Key? key}) : super(key: key);

  @override
  _HomeItemDetailChooseImageWidgetState createState() =>
      _HomeItemDetailChooseImageWidgetState();
}

class _HomeItemDetailChooseImageWidgetState
    extends State<HomeItemDetailChooseImageWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double itemHorMargin = 5;
    double itemVerMargin = 15;
    double itemLength = (width - 5 * itemHorMargin) / 4.0;

    return Container(
      height: itemLength + 2 * itemVerMargin,
      width: double.infinity,
      decoration: BoxDecoration(
        color: RMColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: RMColors.primaryColor.withOpacity(0.3),
            offset: Offset(2.0, 2.0),
            blurRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: itemLength,
            height: itemLength,
            decoration: BoxDecoration(
                color: RMColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)),
            child: Image.asset('assets/imgs/add_img.png'),
          ),
          Container(
            width: itemLength,
            height: itemLength,
            decoration: BoxDecoration(
                color: RMColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            width: itemLength,
            height: itemLength,
            decoration: BoxDecoration(
                color: RMColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            width: itemLength,
            height: itemLength,
            decoration: BoxDecoration(
                color: RMColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}
