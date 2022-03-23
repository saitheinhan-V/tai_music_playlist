import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tai_music/config/url_config.dart';
import 'package:tai_music/model/artist.dart';
import 'package:tai_music/model/genre.dart';
import 'package:tai_music/model/playlist.dart';
import 'package:flutter/material.dart';

class ApiService{

  //get all artist list
  static Future<List<Artist>> getArtistList() async {
    late List<Artist> lists = [];
    var response = await http.get(Uri.parse(UrlConfig.getArtistListUrl));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if(body['code'] == 200) {
        var data = body['data'];

        /*for (var i = 0; i < data.length; i++) {
          Map map = data[i];
          Artist artist = Artist.fromJson(data[i]);
          lists.add(artist);
          print('Artist value >' + artist.toString());
        }*/
        
        lists = (body['data'] as List).map((e) => Artist.fromJson(e)).toList();
      }
    } else {
      throw Exception('Failed to load!');
    }

    print("Artist List>> "+lists.toString());
    return lists;
  }


  //get all playlists
  static Future<List<Playlist>> getAllPlaylist() async{
    late List<Playlist> playlists = [];
    
    var response = await http.get(Uri.parse(UrlConfig.getAllPlaylist));

    if(response.statusCode == 200){
      var body = jsonDecode(response.body);

      if(body['code'] == 200) {
        var data = body['data'];

        for (var i = 0; i < data.length; i++) {

          ApiPlaylist apiPlaylist = ApiPlaylist.fromJson(data[i]);

          var name = apiPlaylist.playlistName;
          var size = 0;

          if(apiPlaylist.songIdList.isNotEmpty) {
            size = apiPlaylist.songIdList.split(',').length;
          }

          late Playlist playlist;

          if(name == 'New Playlist'){
            playlist = Playlist(apiPlaylist.playlistId, apiPlaylist.playlistName, -1, apiPlaylist.songIdList, Icons.add);
          }else if(name == 'Liked Songs'){
            playlist = Playlist(apiPlaylist.playlistId, apiPlaylist.playlistName, size, apiPlaylist.songIdList, Icons.favorite);
          }else if(name == 'Most Played'){
            playlist = Playlist(apiPlaylist.playlistId, apiPlaylist.playlistName, size, apiPlaylist.songIdList, Icons.star);
          }else if(name == 'Recent Played'){
            playlist = Playlist(apiPlaylist.playlistId, apiPlaylist.playlistName, size, apiPlaylist.songIdList, Icons.history_toggle_off_sharp);
          }else{
            playlist = Playlist(apiPlaylist.playlistId, apiPlaylist.playlistName, size, apiPlaylist.songIdList, Icons.fiber_new);

          }

          playlists.add(playlist);

        }
      }
    }else{
      throw Exception('Failed to load!');
    }

    print('Playlist >>>'+playlists.toString());
    return playlists;
  }

  //save new playlist
  static Future<bool> saveNewPlaylist(String name) async{
    var result = false;

    final requestUrl = Uri.parse(UrlConfig.saveNewPlaylist).replace(queryParameters: {
      'playlistName' : name
    });

    var response = await http.post(requestUrl);

    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      if(body['code'] == 200){
        result = true;
        var msg = body['message'];
        print('Message >>'+msg);
      }else{
        result = false;
      }
    }else{
      throw Exception('Failed to save');
    }

    return result;
  }

  //save new playlist
  static Future<bool> removePlaylist(int id) async{
    var result = false;

    final requestUrl = Uri.parse(UrlConfig.removePlaylist).replace(queryParameters: {
      'playlistId' : id.toString()
    });

    var response = await http.post(requestUrl);

    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      if(body['code'] == 200){
        result = true;
        var msg = body['message'];
        print('Message >>'+msg);
      }else{
        result = false;
      }
    }else{
      throw Exception('Failed to save');
    }

    return result;
  }

  static Future<List<Genre>> getAllGenres() async{
    late List<Genre> genreList = [];

    var response = await http.get(Uri.parse(UrlConfig.getAllGenres));

    if(response.statusCode == 200 ){
      var body = jsonDecode(response.body);
      print('Genres >> $body');
      var msg = body['message'];
      var data = body['data'];
      for(var i=0; i<data.length; i++){
        genreList.add(Genre.fromJson(data[i]));
      }

    }else{
      throw Exception('Failed to load data');
    }

    print('Genre List >> $genreList');
    return genreList;
  }
  
}