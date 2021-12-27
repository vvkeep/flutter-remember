import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/model/models.dart';
import 'package:iron_box/pages/home/home_account_category_page.dart';
import 'package:iron_box/pages/home/home_album_list_page.dart';
import 'package:iron_box/pages/home/home_profile_page.dart';

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
    NavigationIconView(title: '相册', icon: APPIcons.phtoto, activeIcon: APPIcons.phtotoSelected),
    NavigationIconView(title: '我的', icon: APPIcons.profile, activeIcon: APPIcons.profileSelected),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      HomeAccountCategoryPage(),
      HomeAlbumListPage(),
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
      fixedColor: APPColors.primaryColor,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
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
