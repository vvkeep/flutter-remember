import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/app_feature_item_model.dart';
import 'dart:math';

import 'package:remember/router/routers.dart';
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
    AppFeatureItemModel(Colors.blue, 'assets/imgs/app_feature.png', "Hi", "It's Me!", 'Remember'),
    AppFeatureItemModel(Colors.deepPurpleAccent, 'assets/imgs/app_feature.png', "Take a", "Safe", 'App'),
    AppFeatureItemModel(RMColors.primaryColor, 'assets/imgs/app_feature.png', "Do", "Try it", 'Thank you')
  ];

  static final fontStype = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

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
            slideIconWidget: Icon(Icons.arrow_back_ios),
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            enableLoop: true,
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
                          style: fontStype,
                        ),
                        Text(
                          dataList[index].text2,
                          style: fontStype,
                        ),
                        Text(
                          dataList[index].text3,
                          style: fontStype,
                        ),
                      ],
                    )
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
                  "Skip to End",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                ),
                onPressed: () {
                  liquidController.animateToPage(page: dataList.length - 1, duration: 600);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: TextButton(
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                ),
                onPressed: () {
                  if (liquidController.currentPage + 1 > dataList.length - 1) {
                    Get.toNamed(Routes.registerPage);
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
