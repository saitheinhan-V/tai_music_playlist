import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/model/genre.dart';
import 'package:tai_music/provider/provider.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  late List<Genre> genreList = [];
  late GenreProvider genreProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // genreList.add(MusicGenre(1,'Pop',"",""));
    // genreList.add(MusicGenre(2,'Rock',"",""));
    // genreList.add(MusicGenre(3,'Hip-Hop',"",""));
    // genreList.add(MusicGenre(1,'EDM',"",""));
    // genreList.add(MusicGenre(1,'R&B',"",""));
    // genreList.add(MusicGenre(1,'Country',"",""));
    // genreList.add(MusicGenre(1,'Folk',"",""));
    // genreList.add(MusicGenre(1,'Jazz',"",""));
    // genreList.add(MusicGenre(1,'Classical',"",""));

    genreProvider = Provider.of<GenreProvider>(context, listen: false);
    genreProvider.loadGenreList();
  }

  @override
  Widget build(BuildContext context) {
    genreList = context.watch<GenreProvider>().genreList;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10.0,
              )
            ])),
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 16 / 8,
                ),
                delegate: SliverChildListDelegate([
                  ...genreList
                      // .sublist(0, 4)
                      .map((e) => TagWidget(
                            genre: e,
                          ))
                      .toList()
                ])

                /*SliverChildBuilderDelegate(
                    (context, index) {
                  return
                      TagWidget(genre: genreList[index]);*/
                /* SizedBox(
                    height: 400.0,
                    child: Card(
                      color: Colors.blueGrey[100 * (index % 9 + 1)],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5.0,
                      // generate blues with random shades
                      // color: Colors.green[Random().nextInt(9) * 100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: genreList[index].genreProfile,
                                fit: BoxFit.fill,
                                height: 100.0, width: 100.0,
                              ),
                            // color: Colors.green,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45.0,
                            decoration: const BoxDecoration(
                                color: Colors.black45,
                                borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(genreList[index].genreName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white,fontSize: 16.0),
                                  ),
                                  flex: 2,
                                ),
                                const Expanded(
                                  flex: 1,
                                    child: Icon(Icons.play_circle_fill,color: Colors.green,))
                              ],
                            ),
                          ),
                        ],
                      )
                    ),*/
                // );
                // },
                // childCount: genreList.length,
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

class MusicGenre {
  late int id;
  late String title;
  late String imgUrl;
  late String description;

  MusicGenre(this.id, this.title, this.imgUrl, this.description);
}

class TagWidget extends StatelessWidget {
  // final TagsModel tag;
  // final MainController con;
  final Genre genre;

  const TagWidget({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GenrePage(
                  tag: tag,
                  con: con,)
            )
        );*/
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              // color: Colors.green[Random().nextInt(9) * 100],
              // color: Colors.blueGrey[100 * (genre.genreId % 9 + 1)],
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    offset: const Offset(1, 1),
                    spreadRadius: 1,
                    blurRadius: 50,
                    blurStyle: BlurStyle.outer),
              ]),
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 5,
                right: -15,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(385 / 360),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: kElevationToShadow[2],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        imageUrl: genre.genreProfile,
                        fit: BoxFit.fill,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(genre.genreName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
