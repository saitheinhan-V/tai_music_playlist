import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:tai_music/config/url_config.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  var pickFile;
  var decodeBytes;
  late var base64String = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _gallery();
                  });
                },
                child: const Text('Pick from gallery'),
              ),
              TextButton(
                onPressed: () {
                  _camera();
                },
                child: const Text('Use camera'),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: pickFile != null
                      ? Image.file(
                          File(pickFile),
                          // fit: BoxFit.cover,
                        )
                      : Container(
                    color: Colors.green,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: decodeBytes != null
                      ? Image.memory(decodeBytes)
                      : Container(
                          color: Colors.red,
                        ),
                ),
              ),
              Text(base64String)
            ],
          ),
        ),
      ),
    );
  }

  _gallery() async {
    final status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      print('Permission granted');
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 10);
      setState(() {
        pickFile = file?.path;
      });

      // final bytes =  Uri.dataFromBytes(File(pickFile).readAsBytesSync()).toString();
      final bytes = File(pickFile).readAsBytesSync();
      String base64Image = base64.encode(bytes); //"data:image/png;base64,"
      // base64String = base64Image;
      // print("img_pan : $base64Image");
      //
      if (base64Image.isEmpty) return;
      //
      decodeBytes = const Base64Decoder().convert(base64Image);
      // final requestUrl = Uri.parse(UrlConfig.imageUploadBase64)
      //     .replace(queryParameters: {'base64': bytes});

      //use base64 image upload
      // var response = await http.post(Uri.parse(UrlConfig.imageUploadBase64),
      // body: {'base64' : base64Image});
      // print('RESponse .>> ${response.body}');
      // if (response.statusCode == 200) {
      //   Fluttertoast.showToast(msg: response.body,toastLength: Toast.LENGTH_LONG);
      // }

      //use Dio
      var dio = Dio();
      FormData formData = FormData.fromMap(
          {
            "file" : await MultipartFile.fromFile(pickFile,filename: 'test.png',contentType: MediaType('image','jpg'))
          }
      );
      var response = await dio.post(UrlConfig.imageUploadNormal,data: formData); //upload to local storage
      print('RESS >> ${response.data}');
      if(response.statusCode == 200){
        Fluttertoast.showToast(msg: response.data,toastLength: Toast.LENGTH_LONG);
      }

      //use file stream image upload
      /*File imageFile = File(pickFile);
      // open a bytestream
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse(UrlConfig.imageUploadNormal);

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      // var multipartFile = http.MultipartFile.fromBytes("file", await File.fromUri(Uri.parse(pickFile)).readAsBytes());
      var multipartFile = http.MultipartFile("file",stream,length,contentType: MediaType('image', 'jpeg'));
      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      // print("RESp >>> ${response.statusCode}");

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        Fluttertoast.showToast(msg: value,toastLength: Toast.LENGTH_LONG);
      });*/


    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {}
  }

  _camera() async {
    final serviceStatus = await Permission.camera.isGranted;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        pickFile = file?.path;
      });

      //use Dio
      var dio = Dio();
      FormData formData = FormData.fromMap(
          {
            "file" : await MultipartFile.fromFile(pickFile,filename: 'test.png',contentType: MediaType('image','jpg'))
          }
      );
      var response = await dio.post(UrlConfig.imageUploadCloud,data: formData); //upload to Cloudinary.com
      print('RESS >> ${response.data}');
      if(response.statusCode == 200){
        Fluttertoast.showToast(msg: response.data['message'],toastLength: Toast.LENGTH_LONG);
      }
      
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }
}
