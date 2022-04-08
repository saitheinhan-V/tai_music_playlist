import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/provider/local_providers.dart';
import 'package:tai_music/ui/home/artist_page.dart';
import 'package:tai_music/ui/home/genre_page.dart';
import 'package:tai_music/ui/home/playlist_page.dart';
import 'package:tai_music/ui/search/search.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../../ant_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    initialIndex: 0,
    length: categoryList.length,
    vsync: this,
  );

  final _scrollController = ScrollController();

  late DateTime _lastPressed;

  late List<String> categoryList = [];

  final List<Widget> pages = [
    const ArtistPage(),
    const PlaylistPage(),
    const GenrePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _categoryList.add('For You');
    // categoryList.add('Artists');
    // categoryList.add('Playlist');
    // categoryList.add('Genre');
    // _categoryList.add('Popular');


  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  late bool _showBottomBar;

  void _showBottomBarByScroll(BuildContext context) {
    final bottomBarState = Provider.of<BottomBarState>(context, listen: false);

    _showBottomBar = bottomBarState.showBottomBar;

    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse &&
        _showBottomBar) {
      bottomBarState.showBottomBar = false;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward &&
        !_showBottomBar) {
      bottomBarState.showBottomBar = true;

    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    categoryList = [
      L10n.of(context)?.artists ?? "Artist",
      L10n.of(context)?.playlist ?? "Playlist",
      L10n.of(context)?.genre ?? "Genre"
    ];

    tabController = TabController(
      initialIndex: 0,
      length: categoryList.length,
      vsync: this,
    );

    return WillPopScope(
      onWillPop: () async {
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
      },
      child: DefaultTabController(
        length: categoryList.length,
        child: Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              _showBottomBarByScroll(context);
              return true;
            },
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: GestureDetector(
                      onTap: (){
                        setState(() {
                          showSearch(context: context, delegate: CustomSearchDelegate());
                        });
                      },
                      child: Container(
                        width: 400.0,
                        height: 40.0,
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children:  <Widget>[
                            const Icon(
                              Icons.search,
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              L10n.of(context)?.search ?? "Search...",
                              style: const TextStyle(
                                color: Colors.black26,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    snap: false,
                    forceElevated: innerBoxScrolled,
                    bottom: TabBar(
                        // isScrollable: true,
                        controller: tabController,
                        labelColor: Colors.green,
                        // labelStyle: theme.textTheme.headline1,
                        indicatorColor: Colors.green,
                        unselectedLabelColor: Colors.grey,
                        tabs: List.generate(
                            categoryList.length,
                            (index) => Tab(
                                  text: categoryList[index],
                                )
                        )
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: List.generate(
                    categoryList.length, (index) => pages[index]
                ),
              ),
            ),
          ),
        ),
         // child:
/*
             CustomScrollView(
               slivers: [
                 SliverAppBar(
                   title: GestureDetector(
                     onTap: () => {},
                     //     showSearch(
                     //   context: context,
                     //   delegate: CustomSearchDelegate()
                     // ),
                     child: Container(
                       width: 400.0,
                       height: 40.0,
                       padding: const EdgeInsets.only(left: 10.0),
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: Colors.grey.shade300,
                           width: 2.0,
                         ),
                         borderRadius: BorderRadius.circular(10.0),
                         color: Colors.grey.shade300,
                       ),
                       child: Row(
                         children: const <Widget>[
                           Icon(
                             Icons.search,
                             color: Colors.black26,
                           ),
                           SizedBox(
                             width: 10.0,
                           ),
                           Text(
                             'Search...',
                             style: TextStyle(
                               color: Colors.black26,
                               fontSize: 15.0,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 TabBarView(
                   controller: tabController,
                   children: List.generate(
                       categoryList.length,
                           (index) => pages[index]
                   ),
                 ),
               ],
             ),
*/
/*
         Scaffold(
          appBar: AppBar(
            title:
            GestureDetector(
              onTap: () => {},
              //     showSearch(
              //   context: context,
              //   delegate: CustomSearchDelegate()
              // ),
              child: Container(
                width: 400.0,
                height: 40.0,
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Search...',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Colors.black,
                ),
                child: Container(),
              ),
            ],
            bottom: TabBar(
                isScrollable: false,
                controller: tabController,
                labelColor: Colors.green,
                // labelStyle: theme.textTheme.headline1,
                indicatorColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                tabs: List.generate(
                    categoryList.length,
                    (index) => Tab(
                          text: categoryList[index],
                        ))),
          ),
          body: TabBarView(
            controller: tabController,
            children: List.generate(
              categoryList.length,
              (index) => pages[index]
            ),
          ),
        ),
*/
      ),
    );
  }
}
