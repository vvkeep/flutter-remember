import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/img_model.dart';

// ignore: must_be_immutable
class ItemDetailChooseImageWidget extends StatefulWidget {
  void Function(RMPickImageItem item, int index) callback;

  List<RMPickImageItem> itemList;

  ItemDetailChooseImageWidget({Key? key, required this.itemList, required this.callback}) : super(key: key);

  @override
  _ItemDetailChooseImageWidgetState createState() => _ItemDetailChooseImageWidgetState();
}

class _ItemDetailChooseImageWidgetState extends State<ItemDetailChooseImageWidget> {
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
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: _buildItemList(itemLength, itemHorMargin)),
    );
  }

  List<Widget> _buildItemList(double itemLength, double itemHorMargin) {
    var max = this.widget.itemList.length >= 4 ? 4 : this.widget.itemList.length;
    var list = this.widget.itemList.sublist(0, max);
    return list.map((item) {
      return GestureDetector(
        onTap: () {
          this.widget.callback(item, list.indexOf(item));
        },
        child: Container(
          margin: EdgeInsets.only(left: itemHorMargin),
          width: itemLength,
          height: itemLength,
          decoration: BoxDecoration(
            color: RMColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: _buildItemWidget(item),
        ),
      );
    }).toList();
  }

  Widget _buildItemWidget(RMPickImageItem item) {
    if (item.type == PickImageMediaType.add) {
      return Image.asset(item.path!, fit: BoxFit.cover);
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(item.file!, fit: BoxFit.cover),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      this.widget.itemList.remove(item);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: RMColors.white,
                  )),
            ),
          )
        ],
      );
    }
  }
}
