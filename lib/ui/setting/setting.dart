import 'dart:math';

// import 'package:easy_localization/src/public_ext.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tai_music/generated/locale_keys.g.dart';
import 'package:tai_music/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:tai_music/hook/use_l10n.dart';
import 'package:tai_music/ui/test/image_upload.dart';

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
  late LanguageProvider languageProvider;

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    currentIndex = 0;
    // settingList.add(Setting(1, "Language", Icons.language));
    // settingList.add(Setting(2, 'Setting', Icons.settings));
    // settingList.add(Setting(3, 'Feedback', Icons.feedback));
    // settingList.add(Setting(0, 'Rate us', Icons.history));
    // settingList.add(Setting(5, 'About', Icons.info));


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var currentLocale = context.watch<LanguageProvider>().locale;

    // var locale = useL10n(context);
    settingList = [
      Setting(1, L10n.of(context)?.language ?? "Language", Icons.language),
      Setting(2, L10n.of(context)?.setting ?? "Setting", Icons.settings),
      Setting(3, L10n.of(context)?.feedback ?? "Feedback", Icons.feedback),
      Setting(0, L10n.of(context)?.rateUs ?? "Rate us", Icons.history),
      Setting(5, L10n.of(context)?.about ?? "About", Icons.info)
    ];

    featureList = [
      Setting(3, L10n.of(context)?.sleepTimer ?? 'Sleep Timer', Icons.timer),
      Setting(4, L10n.of(context)?.addWidget ?? 'Add Widget', Icons.widgets),
      Setting(4, L10n.of(context)?.theme ?? 'Theme', Icons.color_lens)
    ];

    playRecordList = [
      PlayRecord(1, L10n.of(context)?.musicPlayed ?? 'Music Played', '1.2K', L10n.of(context)?.times?? 'times'),
      PlayRecord(2, L10n.of(context)?.listeningTime ?? 'Listening Time', '3.5', L10n.of(context)?.hour?? 'hr'),
      PlayRecord(3, L10n.of(context)?.artists ?? 'Artists', '11', L10n.of(context)?.artistCount?? 'artists'),
      PlayRecord(4, L10n.of(context)?.album ?? 'Albums', '20', L10n.of(context)?.albumCount?? 'albums'),
      PlayRecord(5, L10n.of(context)?.song ?? 'Songs', '300', L10n.of(context)?.songCount?? 'songs'),
      PlayRecord(6, L10n.of(context)?.favourite ?? 'Favourite', '100', L10n.of(context)?.songCount?? 'songs')
    ];

    children.clear();
    currentList.clear();
    currentIndex = 0;
    for (var j = currentIndex; j < playRecordList.length; j += 2) {
      currentList.clear();
      currentList.add(playRecordList[j]);
      currentList.add(playRecordList[j + 1]);
      currentIndex = j + 2;
      children.add(playRecordWidget(context, currentList));
    }

    Locale locale = Localizations.localeOf(context);
    var code = locale.languageCode;

    return Consumer<LanguageProvider>(builder: (context, provider, snapshot) {
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child:  Text(
                    L10n.of(context)?.playbackRecord ?? 'Playback Records',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    height: code == "en"? 280 : 350,
                    child: Column(
                      children: children,
                    )),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Text(
                    L10n.of(context)?.feature ?? 'Features',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: 70.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.builder(
                      itemCount: featureList.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: code == "en" ? 150.0 : 170.0,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageUpload()));
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.grey.shade800.withOpacity(0.5),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(featureList[index].icon),
                                      Text(featureList[index].name),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                )
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, top: 25.0, bottom: 15.0),
                  child: Text(
                    L10n.of(context)?.moreTitle ?? 'Others',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ])),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return index == 0
                      ? Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                var lang = Localizations.localeOf(context);
                                print("Lanugae Code >>> ${lang.languageCode}");
                                showLanguageSelectionDialog(
                                    context, lang.languageCode);
                              });
                            },
                            leading: IconButton(
                              icon: Icon(settingList[index].icon),
                              onPressed: () {},
                            ),
                            title: Text(settingList[index].name),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.4),
                              borderRadius:
                                  const BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(settingList[index].icon),
                              onPressed: () {},
                            ),
                            title: Text(settingList[index].name),
                          ),
                        );
                }, childCount: settingList.length - 1),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0))),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(settingList[4].icon),
                      onPressed: () {},
                    ),
                    title: Text(settingList[4].name),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                )
              ]))
            ],
          ),
        ),
      );
    });
  }

  void showLanguageSelectionDialog(
      BuildContext context, String currentLenguage) {
    var currentValue = currentLenguage;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(L10n.of(context)?.language ?? 'Language'),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: "en",
                    groupValue: currentValue,
                    onChanged: (value) {
                      languageProvider.setLocale(const Locale('en'), context);
                      // await context.setLocale(const Locale('en'));

                      // ref
                      //     .read(cryptoSettings.notifier)
                      //     .setLenguage(LocaleKeys.english);
                      currentValue = value!;
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    L10n.of(context)?.english ?? "English",
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "my",
                    groupValue: currentValue,
                    onChanged: (value) {
                      // await context.setLocale(const Locale('my'));
                      languageProvider.setLocale(const Locale('my'), context);

                      // ref
                      //     .read(cryptoSettings.notifier)
                      //     .setLenguage(LocaleKeys.spanish);
                      currentValue = value!;
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    L10n.of(context)?.myanmar ?? "Myanmar",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Setting {
  late int id;
  late String name;
  late IconData icon;

  Setting(this.id, this.name, this.icon);
}

class PlayRecord {
  late int id;
  late String title;
  late String playCount;
  late String playUnit;

  PlayRecord(this.id, this.title, this.playCount, this.playUnit);
}

Widget playRecordWidget(BuildContext context, List<PlayRecord> playRecords) {
  var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  var color2 = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  return Container(
    // height: 100.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              margin: const EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                // color: Colors.black45,
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Text(
                    playRecords[0].title,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  Text(
                    '${playRecords[0].playCount} ${playRecords[0].playUnit}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              margin: const EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: color2.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Text(
                    playRecords[1].title,
                    style: TextStyle(
                        color: color2.withOpacity(1),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${playRecords[1].playCount} ${playRecords[1].playUnit}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}
