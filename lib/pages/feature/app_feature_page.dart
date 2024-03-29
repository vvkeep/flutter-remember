import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/models.dart';
import 'dart:math';

import 'package:iron_box/router/routers.dart';
import 'package:get/get.dart';

class AppFeaturePage extends StatefulWidget {
  AppFeaturePage({Key? key}) : super(key: key);

  @override
  _AppFeaturePageState createState() => _AppFeaturePageState();
}

class _AppFeaturePageState extends State<AppFeaturePage> {
  int page = 0;
  late LiquidController liquidController;

  List<AppFeatureItemModel> dataList = [
    AppFeatureItemModel(Colors.blue, 'assets/imgs/app_feature.png', "嗨，您好！", "欢迎您使用记得APP"),
    AppFeatureItemModel(Colors.deepPurpleAccent, 'assets/imgs/app_feature.png', "记得将致力于", "保护您最重要的的数字资产"),
    AppFeatureItemModel(APPColors.primaryColor, 'assets/imgs/app_feature.png', "欢迎留下您的宝贵建议", "它对我们非常重要！")
  ];

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe.builder(
            positionSlideIcon: 0.8,
            slideIconWidget:
                this.page == this.dataList.length - 1 ? null : Icon(Icons.arrow_back_ios, color: APPColors.white),
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            enableLoop: false,
            ignoreUserGestureWhileAnimating: true,
            onPageChangeCallback: (int index) {
              setState(() {
                this.page = index;
              });
            },
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                color: dataList[index].color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      dataList[index].image,
                      height: 400,
                      fit: BoxFit.contain,
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Column(
                      children: [
                        Text(
                          dataList[index].text1,
                          style: APPTextStyle.bigTextWhiteW500,
                        ),
                        SizedBox(height: 10),
                        Text(
                          dataList[index].text2,
                          style: APPTextStyle.bigTextWhiteW500,
                        )
                      ],
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(dataList.length, (index) => _buildDot(index)),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: TextButton(
                child: Text(
                  this.page == this.dataList.length - 1 ? "立即体验" : "下一步",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                ),
                onPressed: () {
                  if (liquidController.currentPage + 1 > dataList.length - 1) {
                    Get.offNamed(APPRouter.registerPage);
                  } else {
                    liquidController.jumpToPage(page: liquidController.currentPage + 1);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
