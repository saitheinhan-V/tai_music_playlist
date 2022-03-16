import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tai_music/model/user.dart';
import 'package:tai_music/ui/chart/chart.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > const Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.white,
        iconSize: 20,
        selectedFontSize: 15.0,
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0 ?  const Icon(AntIcons.play_video_fill) :  const Icon(AntIcons.play_video,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1 ?  const Icon(AntIcons.explore_fill) : const Icon(AntIcons.explore,),
              label: 'Chart'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2 ? const Icon(Icons.settings_applications) : const Icon(Icons.settings_applications_outlined,),
              label: 'More'
          ),
          // BottomNavigationBarItem(
          //     icon: _selectedIndex == 3 ?  const Icon(AntIcons.profile_fill) :  const Icon(AntIcons.profile,),
          //     label: '我的'
          // ),
        ],
      ),

    );



  }
}

