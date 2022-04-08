import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tai_music/config/color.dart';
import 'package:tai_music/config/storage_manager.dart';
import 'package:tai_music/config/url_config.dart';
import 'package:tai_music/model/user.dart';
import 'package:tai_music/provider/audio_provider.dart';
import 'package:tai_music/provider/local_providers.dart';
import 'package:tai_music/provider/provider.dart';
import 'package:tai_music/theme/theme_state.dart';
import 'package:tai_music/ui/home/home.dart';
import 'animation/fade_animation.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import 'app.dart';
import 'index_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /*await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('my')],
          path: 'assets/translations',
          // fallbackLocale: const Locale('en'),
          child: const ProviderScope(
              child: MyApp())
      )
  );*/
  runApp(
      const MyApp()
  );
}




