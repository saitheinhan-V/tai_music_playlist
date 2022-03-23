import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tai_music/config/color.dart';
import 'package:tai_music/config/storage_manager.dart';
import 'package:tai_music/config/url_config.dart';
import 'package:tai_music/model/user.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/provider/provider.dart';
import 'package:tai_music/theme/theme_state.dart';
import 'package:tai_music/ui/home/home.dart';
import 'animation/fade_animation.dart';
import 'package:http/http.dart' as http;

import 'index_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          // primaryColor: Colors.amberAccent,
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
          canvasColor: const Color(0xff130f24),
          // canvasColor: const Color(0xff1D1736),
          // canvasColor: Colors.grey.shade300,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xff1D1736),selectedItemColor: Colors.green),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff1D1736),toolbarTextStyle: TextStyle(color: Colors.black)),

        ),
        home:  const Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  const IndexPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  const IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        color: const Color(0xff130f24),
        height: MediaQuery.of(context).size.height,
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
             Image.asset('assets/logo/ic_main_logo.png',height: 100.0,width: 100.0,),
              const SizedBox(height: 50.0,),
              const Text('Tai Music Playlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  bool first=true;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: 'Playlist',
        description: "A collection of Tai songs",
        pathImage: "assets/images/playlist.png",
        backgroundColor: Colors.blueGrey,
      ),
    );

    slides.add(
       Slide(
        title: "Artists",
        description: "Listen to the songs debuted by your favourite artists",
        pathImage: "assets/images/artist.png",
        backgroundColor: const Color(0xf4d7c61d),
      ),
    );
    slides.add(
      Slide(
        title: "Listen",
        description: "Listen to the songs based on genre of songs",
        pathImage: "assets/images/listen.png",
        backgroundColor: Colors.green,
      ),
    );
    slides.add(
      Slide(
        title: "Chord",
        description: "Watch guitar chord lists of your favourite songs",
        pathImage: "assets/images/chord.png",
        backgroundColor: Colors.red,
      ),
    );
    // slides.add(
    //    Slide(
    //     title: "Influencer",
    //     description: "Become influencer with your own fans",
    //     pathImage: "assets/mega-influencer.png",
    //     backgroundColor: Colors.deepPurpleAccent,
    //   ),
    // );


  }

  void onDonePress() {
    Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const IndexPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
    );
  }
}


