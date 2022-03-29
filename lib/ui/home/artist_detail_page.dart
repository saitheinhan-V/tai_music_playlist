import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tai_music/model/artist.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/ui/current_play/current_playing_song.dart';
import 'package:tai_music/widget/back.dart';
import 'package:tai_music/widget/sliver_appbar.dart';

class ArtistDetailPage extends StatefulWidget {
  final Artist artist;
  // const ArtistDetailPage({Key? key}) : super(key: key);

  ArtistDetailPage({required this.artist});

  @override
  _ArtistDetailPageState createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage>  with SingleTickerProviderStateMixin {
  late Artist _artist;
  late AnimationController _animationController;

  late AudioProvider audioProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _artist = widget.artist;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    // print("DETAIL artist > ${_artist.artistName}");
    // _artist = Artist(1, "JJJJ", 'https://i.postimg.cc/7Y1BBV19/mm.jpg');
    audioProvider = Provider.of<AudioProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MyDelegate(
                artist: _artist
            ),
            pinned: true,
            floating: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context,int i){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CurrentPlayingSong(con: audioProvider))
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                      height: 80.0,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('${i+1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),)
                              )
                          ),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,height: 50,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://i.postimg.cc/DZG34m5n/pop.jpg',
                                        progressIndicatorBuilder: (context, url, l) =>
                                        const CircularProgressIndicator(),
                                        fit: BoxFit.cover,
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0,top: 20.0,bottom: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const [
                                           Text('Love song song song song song song song song song song song ',
                                          style:  TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 18
                                          ),
                                          ),
                                           SizedBox(height: 5.0,),
                                           Text('3:30'),
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){

                                },
                                icon: const Icon(Icons.more_vert_outlined),
                              )
                          )
                        ],
                      )
                    ),
                  );
                },
                childCount: 20
            ),
          )
        ],
      )
    );
    /*return Scaffold(
      appBar: AppBar(
        // Overide the default Back button
        automaticallyImplyLeading: false,
        leadingWidth: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,),
        onPressed: ()=> {
          Navigator.of(context).pop()
        },
        ),
        // other stuff
        title: const Center(child: Text('Contact',style: TextStyle(color: Colors.green),)),
      ),
      body: Column(
        children:  const [
           SizedBox(
            height: 55.0,
            child: BackWidget(),
          )
        ],
      ),
    );*/
    /*return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            floating: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              // title: const Text('Goa', textScaleFactor: 1),
              background: Image.asset(
                'assets/images/artist.png',
                fit: BoxFit.fill,
              ),
            ),
            bottom: AppBar(
              title: const SizedBox(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term'),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: const EdgeInsets.all(8),
                      width: 100,
                      child: const Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );*/
    /*return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              floating: true,
              snap: false,
              forceElevated: innerBoxScrolled,
              leading: SizedBox(
                width: 50.0,
                height: 50.0,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                    )),
              ),
              */ /*flexibleSpace: Row(
                children: [
                Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(top: 48.0),
                child: Image.asset('assets/images/playlist.png',width: 50.0,height: 50.0,),
                ),
                  FlexibleSpaceBar(
                    centerTitle: false,
                    title: Row(
                      children:  [
                       */ /*
          */ /* Container(
                          width: 100.0,
                          height: 100.0,
                          margin: const EdgeInsets.only(top: 48.0),
                          child: Image.asset('assets/images/playlist.png',width: 50.0,height: 50.0,),
                        ),*/ /*
          */ /*
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          padding: const EdgeInsets.only(left: 5.0),
                          // width: MediaQuery.of(context).size.width - 100,
                          child:  const Text('TEXTTEXTTEXTTEXT',
                            style: TextStyle(color: Colors.black),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),*/ /*
              flexibleSpace: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 150.0,
                    margin: const EdgeInsets.only(top: 50.0),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/playlist.png'),
                    )
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 0.0,right: 30.0),
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width - 150,
                    child: const FlexibleSpaceBar(
                      title: Text(
                        'StatusStatusStatusStatus',
                        style: TextStyle(color: Colors.black,),
                        textAlign: TextAlign.start,
                      ),
                    )
            ),
          ],
          ),

          )
          ];
        },
        body: const Text('Details'),
      ),
    );*/
  }
}
