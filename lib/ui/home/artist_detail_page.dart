import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tai_music/widget/back.dart';

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({Key? key}) : super(key: key);

  @override
  _ArtistDetailPageState createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
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
              /*flexibleSpace: Row(
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
                       */
          /* Container(
                          width: 100.0,
                          height: 100.0,
                          margin: const EdgeInsets.only(top: 48.0),
                          child: Image.asset('assets/images/playlist.png',width: 50.0,height: 50.0,),
                        ),*/
          /*
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
              ),*/
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
    );
  }
}
