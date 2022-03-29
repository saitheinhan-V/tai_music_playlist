import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/theme/theme_state.dart';
import 'package:tai_music/utils/responsive.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late List<Ranking> popularList = [];
  late List<Ranking> newList = [];
  late List<List<Ranking>> totalRankingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularList.add(Ranking(1, 'Love is blindLove is blindLove is blind', 'William'));
    popularList.add(Ranking(1, 'Love is blind', 'William'));
    popularList.add(Ranking(1, 'Love is blind', 'William'));
    popularList.add(Ranking(1, 'Love is blind', 'William'));
    popularList.add(Ranking(1, 'Love is blind', 'William'));

    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));
    newList.add(Ranking(1, 'TEST', 'Smith'));

    totalRankingList.add(popularList);
    totalRankingList.add(newList);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final theme = themeState.currentTheme;
    final responsive = Responsive.of(context);
    final switchThemeStatus = themeState.isDarkTheme;


    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: BouncingScrollPhysics()
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Popular Songs',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 380.0,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(

                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    late List<Widget> children = [];
                    children.clear();
                    for (var i = 0; i < popularList.length; i++) {
                      children.add(
                        Container(
                          width: 300,
                          // color: Colors.grey.shade800.withOpacity(0.5),
                          child: ListTile(
                            leading: Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10.0),
                              // ),
                              shape: const CircleBorder(),
                              elevation: 10.0,
                              child: SizedBox(
                                  height: 30.0,
                                  width: 30.0,
                                  child: Image.asset(
                                    'assets/images/playlist.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title:  Text(popularList[i].songName),
                            subtitle:  Text(popularList[i].artistName),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert_outlined),
                              onPressed: () {

                              },
                            ),
                          ),
                        ),
                      );
                    }
                   return Card(
                       color: Colors.grey.shade800.withOpacity(0.3),
                      child: Column(
                      children: children
                    )
                    );
                  }
                  ),
                ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'New Songs',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 380.0,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      late List<Widget> children = [];
                      children.clear();
                      for (var i = 0; i < 5; i++) {
                        children.add(
                          Container(
                            width: 300,
                            // color: const Color(0xec1d1837),
                            // color: Colors.grey.shade800.withOpacity(0.5),
                            child: ListTile(
                              leading: Card(
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(10.0),
                                // ),
                                shape: const CircleBorder(),
                                elevation: 10.0,
                                child: SizedBox(
                                    height: 30.0,
                                    width: 30.0,
                                    child: Image.asset(
                                      'assets/images/playlist.png',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              title:  Text(newList[i].songName),
                              subtitle:  Text(newList[i].artistName),
                              trailing: IconButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                onPressed: () {

                                },
                              ),
                            ),
                          ),
                        );
                      }
                      return Card(
                          color: Colors.grey.shade800.withOpacity(0.3),
                          child: Column(
                              children: children
                          )
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chartWidget(BuildContext context,List<Ranking> playList) {
  return ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: ListTile(
            leading: Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              shape: const CircleBorder(),
              elevation: 10.0,
              child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset(
                    'assets/images/playlist.png',
                    fit: BoxFit.cover,
                  )),
            ),
            title:  Text(playList[index].songName),
            subtitle:  Text(playList[index].artistName),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {

              },
            ),
          ),
        );
      },
      separatorBuilder: (ctx, i) {
        return const SizedBox(
          height: 0.0,
        );
      },
      itemCount: playList.length
  );
}

class Ranking {
  late int id;
  late String songName;
  late String artistName;

  Ranking(this.id, this.songName, this.artistName);
}
