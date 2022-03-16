import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tai_music/model/artist.dart';
import 'package:tai_music/ui/home/artist_detail_page.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late List<Artist> artistList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    artistList.add(Artist(1, "Sai Sai", ""));
    artistList.add(Artist(1, "Nang Nang", ""));
    artistList.add(Artist(1, "Sai Sai", ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          // margin: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            // color: Color(0xff1D1736)
          ),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
          itemCount: artistList.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                      child: Image.asset(
                        'assets/images/playlist.png',
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext bc){
                          return Container(
                          decoration:  BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))
                          ),
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                title: Text(artistList[index].artistName),
                                subtitle: const Text('1 Album, 20 songs'),
                                leading: SizedBox(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Image.asset(
                                      'assets/images/playlist.png',
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              Container(height: 1.0,color: Colors.grey,),
                               ListTile(
                                leading:  const Icon(Icons.play_arrow),
                                title:  const Text('Play'),
                                onTap: (){
                                  Navigator.pop(bc);
                                },
                              ),
                               ListTile(
                                leading:  const Icon(Icons.playlist_add_rounded),
                                title:  const Text('Add to Queue'),
                                onTap: (){
                                  setState(() {
                                    Navigator.pop(bc);
                                  });
                                },
                              ),
                              ListTile(
                                leading:  const Icon(Icons.playlist_add_rounded),
                                title:  const Text('Add to Playlist'),
                                onTap: (){
                                  setState(() {
                                    Navigator.pop(bc);
                                  });
                                },
                              ),
                            ],
                          ),
                            );
                        }
                    );
                  },
                  icon: const Icon(Icons.more_vert_outlined),

                )
            ),
          );
      },
    ),
        ));
  }
}
