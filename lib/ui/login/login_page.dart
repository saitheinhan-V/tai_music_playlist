import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tai_music/animation/fade_animation.dart';
import 'package:tai_music/config/url_config.dart';
import 'package:http/http.dart' as http;
import 'package:tai_music/model/user.dart';
import 'package:tai_music/ui/home/home.dart';
import 'package:tai_music/config/storage_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameTextController = TextEditingController();
  late TextEditingController passwordTextController = TextEditingController();
  late TextEditingController phoneTextController = TextEditingController();

  bool registerClicked = false;


  loginApiCall() async {
    String phoneNumber = phoneTextController.text.trim();
    String password = passwordTextController.text.trim();
    String name = usernameTextController.text.trim();

    if (phoneNumber.isEmpty) {
      Fluttertoast.showToast(
        msg: "Phone number required",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Password required",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if(registerClicked){ //sign up

      if(name.isEmpty){
        Fluttertoast.showToast(
          msg: "Name required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        return;
      }

      final requestUrl = Uri.parse(UrlConfig.registerUrl).replace(queryParameters: {
        'phoneNumber': phoneNumber,
        'password': password,
        'name': name
      });
      var response = await http.post(requestUrl);

      print("PHone $phoneNumber Password $password Name $name");
      print("Response >> ${response.body}");
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body.toString());
        if (body['code'] == 200) {
          var msg = body['msg'];

          Fluttertoast.showToast(
            msg: "$msg",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );

          registerClicked = false;
        }
      } else {
        registerClicked = true;
      }

    }else{

      final requestUrl = Uri.parse(UrlConfig.loginUrl).replace(queryParameters: {
        'phoneNumber': phoneNumber,
        'password': password,
      });
      var response = await http.post(requestUrl);

      print("PHone $phoneNumber Password $password");
      print("Response >> ${response.body}");
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body.toString());
        if (body['code'] == 200) {
          var msg = body['msg'];
          var token = body['token'];

          if (body['data'] != null) {
            User user = User.fromJson(body['data']);
            print("user*****" + user.phoneNumber);

            if (token != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const  HomePage()),
              );

              StorageManager.saveString("x-access-token", token);
            }
          }

          Fluttertoast.showToast(
            msg: "$msg",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );

          registerClicked = true;
        }
      } else {}
    }

    /*var response = await http.get(Uri.parse(UrlConfig.getUserListUrl));
    if(response.statusCode == 200){
      print("Response >> ${response.body.toString()}");


    }*/

    /*final queryParameters = {
      'param1': 'one',
      'param2': 'two',
    };
    final uri =
    Uri.https('www.myurl.com', '/api/v1/test/${widget.pk}', queryParameters);
    final response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });*/

    //Use Header with token
    /* var endpointUrl = 'https://www.myurl.com/api/v1/user';
    Map<String, String> queryParams = {
      'param1': '1',
      'param2': '2'
    };

    var headers = {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    }

    String queryString = Uri.parse(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
    var response = await http.get(requestUrl, headers: headers);*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: const Color(0xfff96d34),
                // color: const Color(0xFFC73800),
                width: wid,
                height: 350,
                // child: SvgPicture.asset(
                //   "images/wave8.svg",
                //   fit: BoxFit.fill,
                // ),
              ),
              // ! 0x00FFFFFF
              const Positioned(
                top: 100,
                left: 45,
                child: FadeAnimation(
                  2,
                  Text(
                    "Yoovi ™",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: "Lobster"),
                  ),
                ),
              )
            ],
          ),
          // ! Here input

          Expanded(
            child: Container(
              color: const Color(0xfff96d34),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FadeAnimation(
                      2,
                      Container(
                          width: double.infinity,
                          height: registerClicked? 240 : 180,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: const BoxDecoration(
                            // border: Border.all(
                            //     color: const Color(0xff4f1ed2), width: 1),
                            // boxShadow: const [
                            //   BoxShadow(
                            //       color: Color(0xff4f1ed2),
                            //       blurRadius: 10,
                            //       offset: Offset(1, 1)),
                            // ],
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: registerClicked,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person_outline),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          maxLines: 1,
                                          controller: usernameTextController,
                                          decoration: const InputDecoration(
                                            label: Text(" User-Name ..."),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: registerClicked,
                                child:  const Divider(
                                  height: 5,
                                  thickness: 3,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.phone),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: phoneTextController,
                                        decoration: const InputDecoration(
                                          label: Text(" Phone Number ..."),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                thickness: 3,
                                indent: 30,
                                endIndent: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.password_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        maxLines: 1,
                                        obscureText: true,
                                        controller: passwordTextController,
                                        decoration: const InputDecoration(
                                          label: Text(" Password ..."),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                thickness: 3,
                                indent: 30,
                                endIndent: 30,
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      2,
                      GestureDetector(
                        onTap: () => {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 22, right: 22),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                onPrimary: const Color(0xff4f1ed2),
                                shadowColor: const Color(0xff4f1ed2),
                                elevation: 18,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xff4f1ed2),
                                  Color(0xff4f1ed2)
                                ]),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: GestureDetector(
                                onTap: () => {
                                  loginApiCall()
                                },
                                child: Container(
                                  width: wid - 20,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    registerClicked? 'Sign up' : "Log in",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          registerClicked = !registerClicked;
                        })
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          registerClicked? "Already have account! Log in" : "SingUp if don't have account ",
                          style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}