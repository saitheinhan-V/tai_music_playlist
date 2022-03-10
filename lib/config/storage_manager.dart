import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


class StorageManager {
  /// app全局配置 eg:theme
  late SharedPreferences sharedPreferences;

  /// 临时目录 eg: cookie
  late Directory temporaryDirectory ;


  /// 初始化必备操作 eg:user数据

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    // temporaryDirectory = await getTemporaryDirectory();
    // sharedPreferences = await SharedPreferences.getInstance();
    // localStorage = LocalStorage('LocalStorage');
    // await localStorage.ready;
  }

  static saveString(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static saveInteger(String key,int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static saveDouble(String key,double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static saveBoolean(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = "";
    if(prefs.getString(key) != null) stringValue = prefs.getString(key)!;
    return stringValue;
  }
  static Future<bool> getBoolean(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = false;
    if(prefs.getBool(key) != null) boolValue = prefs.getBool(key)!;
    return boolValue;
  }
  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = 0;
    if(prefs.getBool(key) != null) intValue = prefs.getInt(key)!;
    return intValue;
  }
  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = 0.0;
    if(prefs.getDouble(key) != null) doubleValue = prefs.getDouble(key)!;
    return doubleValue;
  }

}
