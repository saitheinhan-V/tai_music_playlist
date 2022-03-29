import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/model/user.dart';
import 'package:tai_music/provider/local_providers.dart';
import 'package:tai_music/ui/chart/chart.dart';
import 'package:tai_music/ui/custom_bottom_navigation/bottom_nav_bar_widget.dart';
import 'package:tai_music/ui/home/bottom_play_widget.dart';
import 'package:tai_music/ui/home/home.dart';
import 'package:tai_music/ui/home/home_page.dart';
import 'package:tai_music/ui/login/login_page.dart';
import 'package:tai_music/ui/setting/setting.dart';

import 'ant_icon.dart';



class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin{

  final _pageController = PageController();
  int _selectedIndex = 0;
  late DateTime _lastPressed;
  final List<Widget> pages = [
    const MainPage(),const ChartPage(),const SettingPage()

  ];


  /*onWillPop: () async {

  final differeance = DateTime.now().difference(_lastPressed);
  _lastPressed = DateTime.now();
  if (differeance >= const Duration(seconds: 2)) {
  const String msg = 'Press the back button to exit';
  Fluttertoast.showToast(
  msg: msg,
  );
  return false;
  } else {
  Fluttertoast.cancel();
  SystemNavigator.pop();
  return true;
  }
},*/
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (_lastPressed == null ||
        DateTime.now().difference(_lastPressed) > const Duration(seconds: 1)) {
      _lastPressed = now;
      Fluttertoast.showToast(msg: 'Click again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {

    final bottomBarState = Provider.of<BottomBarState>(context);
    final screensState = Provider.of<ScreensState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        itemBuilder: (ctx, index) => pages[index],
        itemCount: pages.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomCupertinoTabBar(
        // bottomPlayWidget: const PlayWidget(),
        bottomPlayWidget:  Container(),
        showBar: bottomBarState.showBottomBar,
        // activeColor: Colors.white,
        backgroundColor: const Color(0xff1D1736),
        iconSize: 20,
        // selectedFontSize: 15.0,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AntIcons.play_video),
            label: 'Home',
            activeIcon: Icon(AntIcons.play_video_fill),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(AntIcons.explore_fill),
            label: 'Explore',
            icon: Icon(AntIcons.explore),
          ),
          BottomNavigationBarItem(
            label: 'More',
            activeIcon: Icon(Icons.settings_applications),
            icon: Icon(Icons.settings_applications_outlined),
          ),
        ],
      ),

    );



  }
}

