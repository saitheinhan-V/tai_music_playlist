import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tai_music/config/storage_manager.dart';
import 'package:tai_music/config/url_config.dart';
import 'package:tai_music/model/user.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  // final User user;

  // const HomePage({Key? key, required this.user});
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user = User(0,"","","");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user = widget.user;
    print('User >> ${user.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff4f1ed2), Color(0xff4f1ed2)]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                onTap: ()=> {
                  welcomeApiCall()
                },
                child: const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  welcomeApiCall() async{

    String token = await StorageManager.getString("x-access-token");
    // String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozLCJ1c2VyX3Bob25lIjoiMDkyNTk0MDAyMDUiLCJpYXQiOjE2NDY4ODU1MTEsImV4cCI6MTY0Njg5MjcxMX0.z7TEkYB7OPhn0IcAd7nNIECUfRbQCSjmSfB1L5rchfc";
    if(token.isEmpty) return;

    // var headers = {
    //   HttpHeaders.authorizationHeader: 'Token $token',
    //   HttpHeaders.contentTypeHeader: 'application/json',
    // };

    print('Token >> $token');
    var response = await http.get(Uri.parse(UrlConfig.welcomeUrl), headers: {"x-access-token": token});

    print("REsponse >> ${response.body}");
    if(response.statusCode == 200){
      var body = jsonDecode(response.body.toString());
      var msg = body['msg'];
      var user = jsonDecode(body['data']);

      print('User $user');
      Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }

  }
}
