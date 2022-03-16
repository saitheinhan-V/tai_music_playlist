import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late List<Setting> settingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingList.add(Setting(0, 'History', Icons.history));
    settingList.add(Setting(1, 'Setting', Icons.settings));
    settingList.add(Setting(2, 'Feedback', Icons.feedback));
    settingList.add(Setting(3, 'Sleep Timer', Icons.timer));
    settingList.add(Setting(4, 'Add Widget', Icons.widgets));
    settingList.add(Setting(5, 'About', Icons.info));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),

        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context,int index){
                      return ListTile(
                        leading: IconButton(
                          icon:  Icon(settingList[index].icon),
                          onPressed: (){

                        },
                        ),
                        title: Text(settingList[index].name),

                      );
                    },
                  childCount: settingList.length
                ),
            ),
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
