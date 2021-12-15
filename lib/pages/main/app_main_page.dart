import 'package:flutter/material.dart';
import 'package:remember/common/constant.dart';
import 'package:remember/model/models.dart';
import 'package:remember/pages/home/home_account_category_page.dart';
import 'package:remember/pages/home/home_photo_category_page.dart';
import 'package:remember/pages/home/home_profile_page.dart';

class AppMainPage extends StatefulWidget {
  AppMainPage({Key? key}) : super(key: key);

  @override
  _AppMainPageState createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  late List<Widget> _pages;

  List<NavigationIconView> _navigationViews = [
    NavigationIconView(title: '首页', icon: Icons.home_outlined, activeIcon: Icons.home),
    NavigationIconView(title: '相册', icon: Icons.photo_album_outlined, activeIcon: Icons.photo_album),
    NavigationIconView(title: '我的', icon: Icons.settings_outlined, activeIcon: Icons.settings),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      HomeAccountCategoryPage(),
      HomePhotoCategoryPage(),
      HomeProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: RMColors.primaryColor,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
          // _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}