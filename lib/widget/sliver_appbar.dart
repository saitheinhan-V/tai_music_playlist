import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tai_music/model/artist.dart';


double _appTopBarHeight = 60;
String artistName = 'Dennis Lloyd';

class MyDelegate extends SliverPersistentHeaderDelegate {
  // final UserModel user;
  // final MainController con;
  // final List<SongModel> songs;
  final Artist artist;
  MyDelegate({
    required this.artist,
    // required this.con,
    // required this.songs,
  });
  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    var shrinkPercentage =
        min(1, shrinkOffset / (maxExtent - minExtent)).toDouble();

    return Stack(
      clipBehavior: Clip.hardEdge,
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _appTopBarHeight,
            color: Colors.transparent,
          ),
        ),
        Column(
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  ClipRRect(
                    child: Container(
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          tileMode: TileMode.mirror,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      height: _appTopBarHeight + 35,
                      child: Stack(
                        children: [
                          Hero(
                            tag: 'artist-detail',
                            placeholderBuilder: (
                                BuildContext context,
                                Size heroSize,
                                Widget child,
                                ) {
                              return Container(
                                width: heroSize.width,
                                height: heroSize.height,
                                color: Colors.red,
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: artist.artistProfile,
                              height: 40,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                            ),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                            child: Container(
                              height: 60,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 1 - shrinkPercentage,
                    child: Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.topCenter,
                          image: CachedNetworkImageProvider(artist.artistProfile),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           /* DecoratedBox(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, -23),
                  spreadRadius: 2,
                  blurRadius: 50,
                )
              ]),
              child: ClipRRect(
                child: Container(
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.mirror,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  height: 70,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: artist.artistProfile,
                          height: 40,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Opacity(
                              opacity: max(1 - shrinkPercentage * 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: .5, color: Colors.white)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                       artist.artistName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )*/
          ],
        ),
        Stack( //top scroll
          clipBehavior: Clip.hardEdge,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: SizedBox(
                      height: _appTopBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => {
                              // Navigator.pop(context)
                              if (Navigator.canPop(context))
                                {Navigator.pop(context)}
                              else
                                {SystemNavigator.pop()}
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Flexible(
                            child: Opacity(
                              opacity: shrinkPercentage,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10.0,left: 10.0),
                                    width: 40.0,
                                    height: 40.0,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: artist.artistProfile,
                                        progressIndicatorBuilder: (
                                            context, url, l) =>
                                        const CircularProgressIndicator(),
                                        fit: BoxFit.cover,
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    artist.artistName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: max(1 - shrinkPercentage * 6, 0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned( //before scroll TEXT NAME
                bottom: 20,
                child: Opacity(
                  opacity: max(1 - shrinkPercentage * 6, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(artist.artistName,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                                    fontSize: 48,)),
                    ),
                  ),
                )),
            /*Positioned(
              bottom: 10,
              right: 10,
              child: con.player.builderCurrent(builder: (context, playing) {
                Function eq = const ListEquality().equals;
                bool isSame =
                    eq(con.player.playlist!.audios, con.convertToAudio(songs));
                return PlayerBuilder.isPlaying(
                    player: con.player,
                    builder: (context, isPlaying) {
                      return FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          if (isSame) {
                            con.player.playOrPause();
                          } else {
                            con.playSong(con.convertToAudio(songs), 0);
                          }
                        },
                        child: isSame
                            ? Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.black,
                                size: 35,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 35,
                              ),
                      );
                    });
              }),
            )*/
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
