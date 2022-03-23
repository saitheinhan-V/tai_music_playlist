import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/model/artist.dart';
import 'package:tai_music/model/song_model.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/provider/provider.dart';
import 'package:tai_music/ui/home/artist_detail_page.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late List<Artist> artistList = [];
  late ArtistProvider artistProvider;
  late AudioProvider con;
  late List<Audio> audios;
  late Audio myAudio;
  late List<SongModel> songs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    artistProvider.loadData();
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

    songs.add(SongModel('1','TEST','1',
        'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
    '3','https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'Welcome Song'));

    /*artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));*/
  }

  @override
  Widget build(BuildContext context) {
    // artistList = Provider.of<ArtistProvider>(context,listen: true).loadData();
    // artistProvider = Provider.of<ArtistProvider>(context,listen: false);
    artistList = context.watch<ArtistProvider>().artistList;

    return Scaffold(
        body: Container(
      // margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          // color: Color(0xff1D1736)
          ),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        // itemCount: artistProvider.artistList.length,
        itemCount: artistList.length,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical,
        separatorBuilder: (ctx, i) {
          return const SizedBox(
            height: 5.0,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArtistDetailPage()))
            },
            child: ListTile(
                title: Text(artistList[index].artistName),
                subtitle: const Text('1 Album, 20 songs'),
                leading: Card(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  shape: const CircleBorder(),
                  elevation: 10.0,
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    // child: CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     artistList[index].artistProfile,
                    //   ),
                    // ),
                    child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: artistList[index].artistProfile,
                          progressIndicatorBuilder: (context, url, l) =>
                          const CircularProgressIndicator(),
                          fit: BoxFit.cover,
                          width: 50.0, height: 50.0,
                        ),
                      )
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext bc) {
                          return Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff1D1736),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0))),
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  title: Text(artistList[index].artistName),
                                  subtitle: const Text('1 Album, 20 songs'),
                                  leading: Card(
                                    shape: const CircleBorder(),
                                    elevation: 10.0,
                                    child: SizedBox(
                                        height: 50.0,
                                        width: 50.0,
                                        child:
                                        /*ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          // child: CachedNetworkImage(
                                          //   imageUrl: artistList[index].artistProfile,
                                          //   fit: BoxFit.cover,
                                          //   height: 50.0, width: 50.0,
                                          // ),
                                          child: Image.network(
                                            artistList[index].artistProfile,
                                            fit: BoxFit.cover,
                                          ),
                                        )*/
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: artistList[index].artistProfile,
                                          progressIndicatorBuilder: (context, url, l) =>
                                          const CircularProgressIndicator(),
                                          fit: BoxFit.cover,
                                          width: 50.0, height: 50.0,
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.play_arrow),
                                  title: const Text('Play'),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(bc);
                                      con.playSong(con.convertToAudio(songs), 0);
                                    });
                                  },
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.playlist_add_rounded),
                                  title: const Text('Add to Queue'),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(bc);
                                    });
                                  },
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.playlist_add_rounded),
                                  title: const Text('Add to Playlist'),
                                  onTap: () {
                                    setState(() {
                                      Navigator.pop(bc);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.more_vert_outlined),
                )),
          );
        },
      ),
    ));
  }
}
