import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tai_music/ui/home/artist_page.dart';
import 'package:tai_music/ui/home/genre_page.dart';
import 'package:tai_music/ui/home/playlist_page.dart';

import '../../ant_icon.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{

  late TabController tabController = TabController(
    initialIndex: 0,
    length: categoryList.length,
    vsync: this,
  );

  final List<String> categoryList = [];

  final List<Widget> pages = [
    const ArtistPage(),const PlaylistPage(),const GenrePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _categoryList.add('For You');
    categoryList.add('Artists');
    categoryList.add('Playlist');
    categoryList.add('Genre');
    // _categoryList.add('Popular');

    tabController = TabController(
      initialIndex: 0,
      length: categoryList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: categoryList.length,
      child: Scaffold(
        appBar: AppBar(
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
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
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
             /* PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return _action.map((Action action) {
                    return PopupMenuItem(
                      value: action,
                      child: Container(
                        width: 75.0,
                        color: Colors.black,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              action.icon,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              action.title,
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList();
                },
                icon: Column(
                  children: const <Widget>[
                    Icon(
                      AntIcons.add,
                      color: Colors.white,
                      size: 23,
                    ),
                    SizedBox(
                      height: 1.5,
                    ),
                    Text(
                      '发布',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
                offset: const Offset(0, 100),
                onSelected: _onSelected,
              ),*/
            ),
          ],
          bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              labelColor: Colors.amberAccent,
              // labelStyle: theme.textTheme.headline1,
              indicatorColor: Colors.amberAccent,
              unselectedLabelColor: Colors.white,
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
    );
  }
}
