import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tai_music/ui/home/artist_page.dart';
import 'package:tai_music/ui/home/genre_page.dart';
import 'package:tai_music/ui/home/playlist_page.dart';
import 'package:tai_music/ui/search/search.dart';

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

  final List<String> categoryList = [];

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
        body: NestedScrollView(
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
            children: List.generate(categoryList.length, (index) => pages[index]),
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
    );
  }
}
