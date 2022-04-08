// import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale,BuildContext context){
    // if(!L10n.all.contains(locale)) return;
    // await context.setLocale(locale);
    _locale = locale;
    notifyListeners();
  }
}