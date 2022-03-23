import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/model/playlist.dart';
import 'package:tai_music/provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  late List<Playlist> playList = [];
  String playlistName = "";
  late TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late bool isWriting = false;
  late bool validate = true;

  late PlaylistProvider playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    playlistProvider.loadPlayList();
    // playList.add(Playlist(1, 'New Playlist', 0, Icons.add));
    // playList.add(Playlist(2, "Liked Songs", 12, Icons.favorite));
    // playList.add(Playlist(2, "Most Played", 100, Icons.star));
    // playList.add(Playlist(2, "Recent Played", 10, Icons.history_toggle_off_sharp));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    playList = context.watch<PlaylistProvider>().playList;

    return Scaffold(
        body: CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return index != 0
                  ? ListTile(
                      leading: Card(
                        // margin: const EdgeInsets.all(15),
                        // shape: const CircleBorder(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 10.0,
                        color: Colors.green[100 * (index % 9 + 1)],
                        child: Container(
                          // color: Colors.blue[100 * (index % 9 + 1)],
                          height: 80,
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Icon(
                            playList[index].iconData,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        playList[index].name,
                        // style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("${playList[index].songCount} song"),
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
                                        title: Text(playList[index].name),
                                        subtitle: Text(
                                            '${playList[index].songCount} song'),
                                        leading: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors
                                                .green[100 * (index % 9 + 1)],
                                          ),
                                          child: Icon(playList[index].iconData),
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
                                          Navigator.pop(bc);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                            Icons.playlist_add_rounded),
                                        title: const Text('Add to Queue'),
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(bc);
                                          });
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: const Text('Edit'),
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(bc);
                                          });
                                        },
                                      ),
                                      (playList[index].id == 2 ||
                                              playList[index].id == 3 || playList[index].id == 4)
                                          ? Container()
                                          : ListTile(
                                              leading: const Icon(
                                                  Icons.delete_forever),
                                              title: const Text('Delete'),
                                              onTap: () {
                                                setState(() {

                                                  playlistProvider.removePlayList(playList[index].id);
                                                  playlistProvider.loadPlayList();
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
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            addNewPlaylistDialog(context);
                          });
                        },
                        leading: Card(
                          // margin: const EdgeInsets.only(top: 10.0),
                          // shape: const CircleBorder(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10.0,
                          color: Colors.green[100 * (index % 9 + 2)],
                          child: Container(
                            // color: Colors.blue[100 * (index % 9 + 1)],
                            height: 80,
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Icon(
                              playList[index].iconData,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          playList[index].name,
                          // style: const TextStyle(fontSize: 20),
                        ),
                        // trailing: IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(Icons.more_vert_outlined),
                        // ),
                      ),
                    );
            },
            childCount: playList.length, // 1000 list items
          ),
        ),
      ],
    ));
  }

  isWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  addNewPlaylistDialog(BuildContext context) async {
    // if (playlistName.isNotEmpty && playlistName != "Caption...") {
    //   nameController.text = playlistName;
    // }

    nameController.text = "";

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 110.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('New Playlist'),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      controller: nameController,
                      maxLines: null,
                      maxLength: 100,
                      autofocus: true,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: "Caption...",
                        // border: InputBorder.none,
                        // focusedBorder: InputBorder.none,
                        //errorText: validate? null : 'please enter at least 5',
                      ),
                      onChanged: (val) {
                        (val.isNotEmpty) ? isWriting = true : isWriting = false;
                        print('New list $val $isWriting');
                      },
                    ),
                  ),
                  /*Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      height: 17.0,
                      child: Text(
                        'min 5 ~ max 50',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      )
                  ),*/
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    if (isWriting == true) {
                      validate = true;
                      playlistName = nameController.text;
                      playlistProvider.savePlayList(playlistName);
                      playlistProvider.loadPlayList();
                      //playList.add(Playlist(playList[playList.length-1].id+1,playlistName,0,Icons.fiber_new));
                      Navigator.of(context).pop();
                    } else {
                      validate = false;
                    }
                  });
                },
              )
            ],
          );
        });
  }
}
