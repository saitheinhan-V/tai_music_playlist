import 'package:flutter/cupertino.dart';

class Playlist{
  late int id;
  late String name;
  late int songCount;
  late String songList;
  late IconData iconData;

  Playlist(this.id, this.name, this.songCount, this.songList, this.iconData);

}

class ApiPlaylist{
  late int playlistId;
  late int userId;
  late String songIdList;
  late String playlistName;
  late String createdDate;

  ApiPlaylist(this.playlistId, this.userId, this.songIdList, this.playlistName,
      this.createdDate);

  ApiPlaylist.fromJson(Map<dynamic, dynamic> json){
    playlistId = json['playlistId'];
    userId = json['userId'];
    songIdList = json['songIdList'];
    playlistName = json['playlistName'];
    createdDate = json['createdDate'];
  }
}