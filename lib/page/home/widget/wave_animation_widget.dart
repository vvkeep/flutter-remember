import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';

class WaveAnimaitonWidget extends StatefulWidget {
  WaveAnimaitonWidget({Key? key}) : super(key: key);

  @override
  _WaveAnimaitonWidgetState createState() => _WaveAnimaitonWidgetState();
}

class _WaveAnimaitonWidgetState extends State<WaveAnimaitonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final double _waveLength = 300; //波浪长

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2800));
    animation =
        Tween<double>(begin: 0, end: _waveLength).animate(animationController)
          ..addListener(() {
            setState(() {});
          });
    animationController.repeat();
  }

  @override
  void deactivate() {
    super.deactivate();
    animationController.stop();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierPainter1(animation.value, _waveLength),
    );
  }
}

class BezierPainter1 extends CustomPainter {
  final double myOffsetX; //平移量
  final int _waveHeight = 30; //波浪高
  final double waveLength; //一个波浪的长度

  late Paint _pathPaint; //线画笔
  late Paint _whitePaint; //空白画笔

  late double _screenHeight; //屏幕高
  late double _screenWidth; //屏幕宽
  late double _centerY; //屏幕中间Y坐标

  int _waveCount = 0; //波浪个数

  Path _path = Path(); //路径

  BezierPainter1(this.myOffsetX, this.waveLength) {
    _pathPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1;

    _whitePaint = Paint()
      ..color = RMColors.primaryColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _screenHeight = size.height; //屏幕高,这里不是一直成立,像当有Center 父控件的时候就不成立
    _screenWidth = size.width; //屏幕宽

    //把画布裁剪当前矩形,这样怎么画都看不大超出视频外的波浪线
    Rect rect = Rect.fromLTRB(0, 0, _screenWidth, _screenHeight);
    _path.addRect(rect);
    canvas.clipPath(_path);
    canvas.drawRect(Rect.largest, _whitePaint);
    _path.reset();

    _waveCount = (_screenWidth / waveLength).round() +
        2; //根据波长算出波的个数,这里的波浪个数多一点,这样可以在屏幕内看到更完整的波浪
    _centerY = _screenHeight / 2; //中心高度的值
    _path.moveTo(
        -waveLength + this.myOffsetX, _centerY); //把画笔的起点移到屏幕外的一个波长处,Y轴在屏幕中间
    //this.myOffsetX水平方向的偏移量
    for (int i = 0; i < _waveCount; i++) {
      canvas.save();
      canvas.restore();
      //绘制波谷,控制点在(-3M/4,_centerY),结束点在(-waveLength / 2,_centerY)
      //此处可以先把(waveLength * i) + this.myOffsetX 这段代码移除,所画的就是一个波谷,屏幕外的波谷
      _path.quadraticBezierTo(
          -waveLength / 4 * 3 + (waveLength * i) + this.myOffsetX,
          _centerY + _waveHeight,
          -waveLength / 2 + (waveLength * i) + this.myOffsetX,
          _centerY);
      //绘制波峰,控制点在(-M/4,_centerY),结束点在(0,_centerY)
      //此处可以先把(waveLength * i) + this.myOffsetX 这段代码移除,所画的就是一个波峰,屏幕外的波峰
      _path.quadraticBezierTo(
          -waveLength / 4 + (waveLength * i) + this.myOffsetX,
          _centerY - _waveHeight,
          0 + waveLength * i + this.myOffsetX,
          _centerY);
      canvas.drawPath(_path, _whitePaint); //绘制
    }

    ///封闭绘制区域,构成“深水面”
    _path.lineTo(_screenWidth, _screenHeight); //将画笔从当前位置画到屏幕最右下角
    _path.lineTo(0, _screenHeight); //画到屏幕左下角
    _path.close();
    canvas.drawPath(_path, _pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
