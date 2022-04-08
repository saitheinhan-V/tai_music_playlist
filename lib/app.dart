import 'dart:async';

// import 'package:easy_localization/src/public_ext.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/provider/language_provider.dart';
import 'package:tai_music/provider/local_providers.dart';
import 'package:tai_music/provider/provider.dart';
import 'package:tai_music/theme/theme_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


import 'index_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // LocalJsonLocalization.delegate.directories = ['assets/translations'];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => BottomBarState()),
        ChangeNotifierProvider(create: (_) => ScreensState()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),


      ],
      child: Consumer<LanguageProvider>(
        builder: (context, provider, snapshot){
          return MaterialApp(
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
            localizationsDelegates: const [
              L10n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('my'),
            ],
            // supportedLocales: L10n.all,
            // localizationsDelegates: const [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            //    L10n.delegate,
            // ],
            // localizationsDelegates: L10n.localizationsDelegates,
            // supportedLocales: L10n.supportedLocales,
            // supportedLocales: const [
            //   Locale('en'),
            //   Locale('my'),
            //   // Locale('pt', 'BR'),
            // ],
            locale: provider.locale,
            // builder: (context, child) {
            //   return MediaQuery(
            //     child: ScrollConfiguration(
            //       behavior: NoGlowBehavior(),
            //       child: child!,
            //     ),
            //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            //   );
            // },
            home:  const Splash(),
            debugShowCheckedModeBanner: false,
          );
        },
      )
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
          MaterialPageRoute(builder: (context) =>   IndexPage()));
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
        backgroundColor: const Color(0xf49a6a85),//0xf4f9d161
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
        MaterialPageRoute(builder: (context) => IndexPage())
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

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}