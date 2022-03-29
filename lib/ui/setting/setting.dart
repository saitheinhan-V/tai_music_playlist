import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late List<Setting> settingList = [];
  late List<Setting> featureList = [];
  late List<PlayRecord> playRecordList = [];
  late List<Widget> children = [];
  late List<PlayRecord> currentList = [];
  late int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
    settingList.add(Setting(1, 'Setting', Icons.settings));
    settingList.add(Setting(2, 'Feedback', Icons.feedback));
    settingList.add(Setting(0, 'Rate us', Icons.history));
    settingList.add(Setting(5, 'About', Icons.info));

    featureList.add(Setting(3, 'Sleep Timer', Icons.timer));
    featureList.add(Setting(4, 'Add Widget', Icons.widgets));
    featureList.add(Setting(4, 'Theme', Icons.color_lens));



    playRecordList.add(PlayRecord(1, 'Music Played', '1.2K', 'times'));
    playRecordList.add(PlayRecord(2, 'Listening Time', '3.5', 'hr'));
    playRecordList.add(PlayRecord(3, 'Artists', '11', 'artists'));
    playRecordList.add(PlayRecord(4, 'Albums', '20', 'albums'));
    playRecordList.add(PlayRecord(5, 'Songs', '300', 'songs'));
    playRecordList.add(PlayRecord(6, 'Favourite', '100', 'songs'));


    children.clear();
    currentList.clear();
    currentIndex = 0;
    for (var j = currentIndex; j < playRecordList.length; j+=2) {
      currentList.clear();
      currentList.add(playRecordList[j]);
      currentList.add(playRecordList[j + 1]);
      currentIndex = j + 2;
      children.add(playRecordWidget(context, currentList));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                   Container(
                     margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                    child: const Text(
                        'Playback Records',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 280.0,
                    child: Column(
                      children: children,
                    )
                  ),
                ])
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                    child: const Text(
                      'Features',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                      itemCount: featureList.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context,int index){
                          return SizedBox(
                            width: 150.0,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.grey.shade800.withOpacity(0.5),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(featureList[index].icon),
                                    Text(featureList[index].name),
                                  ],
                                ),
                              )
                            ),
                          );
                        }
                    ),
                  )
                ])
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 15.0,top: 25.0,bottom: 15.0),
                    child: const Text(
                      'Others',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ])
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context,int index){
                      return index == 0 ? Container(
                        margin: const EdgeInsets.only(left: 10.0,right: 10.0,),
                        decoration:  BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(0.4),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0))
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon:  Icon(settingList[index].icon),
                            onPressed: (){

                          },
                          ),
                          title: Text(settingList[index].name),

                        ),
                      ) :
                      Container(
                        margin: const EdgeInsets.only(left: 10.0,right: 10.0,),
                        decoration:  BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(0.4),
                            borderRadius: const BorderRadius.all(Radius.zero)
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon:  Icon(settingList[index].icon),
                            onPressed: (){

                            },
                          ),
                          title: Text(settingList[index].name),

                        ),
                      );
                    },
                  childCount: settingList.length-1
                ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 10.0,right: 10.0,),
                    decoration:  BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
                    ),
                    child: ListTile(
                      leading: IconButton(
                        icon:  Icon(settingList[3].icon),
                        onPressed: (){

                        },
                      ),
                      title: Text(settingList[3].name),

                    ),
                  ),
                  const SizedBox(height: 15.0,)
            ]))
          ],
        ),
      ),
    );
  }
}

class Setting{
  late int id;
  late String name;
  late IconData icon;

  Setting(this.id, this.name, this.icon);
}

class PlayRecord{
  late int id;
  late String title;
  late String playCount;
  late String playUnit;

  PlayRecord(this.id, this.title, this.playCount, this.playUnit);
}

Widget playRecordWidget(BuildContext context,List<PlayRecord> playRecords){

  var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  var color2 = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  return Container(
    // height: 100.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:  [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
              margin: const EdgeInsets.only(right: 5.0),
              decoration:  BoxDecoration(
                // color: Colors.black45,
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Text(playRecords[0].title,
                    style:  TextStyle(color: color,fontWeight: FontWeight.bold),
                  ),
                  Text('${playRecords[0].playCount} ${playRecords[0].playUnit}',
                    style: const TextStyle(fontSize: 18.0),),
                ],
              ),
            )
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
              margin: const EdgeInsets.only(left: 5.0),
              decoration:  BoxDecoration(
                color: color2.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.vertical,
                spacing: 10,
                children: [
                Text(playRecords[1].title,
                  style: TextStyle(color: color2.withOpacity(1),fontWeight: FontWeight.bold),
                ),
                Text('${playRecords[1].playCount} ${playRecords[1].playUnit}',
                style: const TextStyle(fontSize: 15.0),),
                ],
              ),
            )
        ),
      ],
    ),
  );
}


