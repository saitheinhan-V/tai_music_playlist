import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:spotify_clone/screens/current_playing/current_playing_song.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/utils/loading.dart';


/*class PlayWidget extends StatelessWidget {
  final MainController con;
  const PlayWidget({
    Key? key,
    required this.con,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return con.player.builderCurrent(builder: (context, playing) {
      final myAudio = con.find(con.audios, playing.audio.assetAudioPath);
      return InkWell(
        onTap: () {
          *//*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CurrentPlayingSong(
                con: con,
              ),
            ),
          );*//*
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: kElevationToShadow[9],
          ),
          child: ClipRRect(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: myAudio.metas.image!.path,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  progressIndicatorBuilder: (context, url, l) =>
                      const LoadingImage(),
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl: myAudio.metas.image!.path,
                                  width: 40,
                                  height: 40,
                                  progressIndicatorBuilder: (context, url, l) =>
                                      const LoadingImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myAudio.metas.title!,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        myAudio.metas.artist!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PlayerBuilder.isPlaying(
                            player: con.player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  con.player.playOrPause();
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}*/

class PlayWidget extends StatefulWidget {
  const PlayWidget({Key? key}) : super(key: key);

  @override
  _PlayWidgetState createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> {

  late AudioProvider con;
  late List<Audio> audios = [];
  late Audio myAudio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = Provider.of<AudioProvider>(context,listen: false);

    audios = <Audio>[
      Audio.network(
        'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
        metas: Metas(
          id: 'Online',
          title: 'Welcome Here',
          artist: 'Ansh Rathod',
          album: 'OnlineAlbum',
          image: const MetasImage.network(
              'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
        ),
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {


    return con.player.builderCurrent(builder: (context, playing) {
      // final myAudio = con.find(con.audios, playing.audio.assetAudioPath);
      myAudio = context.watch<AudioProvider>().find(audios, playing.audio.assetAudioPath);
      print('MyAudio >> $myAudio');
      return InkWell(
        onTap: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CurrentPlayingSong(
                con: con,
              ),
            ),
          );*/
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: kElevationToShadow[9],
          ),
          child: ClipRRect(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: myAudio.metas.image!.path,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  progressIndicatorBuilder: (context, url, l) =>
                  const LoadingImage(),
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: CachedNetworkImage(
                                  imageUrl: myAudio.metas.image!.path,
                                  width: 40,
                                  height: 40,
                                  progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myAudio.metas.title!,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        myAudio.metas.artist!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PlayerBuilder.isPlaying(
                            player: con.player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  con.player.playOrPause();
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

