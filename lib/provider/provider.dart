import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tai_music/config/api_service.dart';
import 'package:tai_music/model/artist.dart';
import 'package:tai_music/model/genre.dart';
import 'package:tai_music/model/playlist.dart';

class ArtistProvider extends ChangeNotifier{

  List<Artist> artistList = [];

  List<Artist> get getArtistList => artistList;

  loadData() async {
    //return await ApiService.getArtistList();
    artistList = await ApiService.getArtistList();
    print('AFTER >> = $artistList');
    notifyListeners();
  }

}

class PlaylistProvider extends ChangeNotifier{

  List<Playlist> playList = [];
  bool saveResult = false;

  List<Playlist> get getPlaylist => playList;

  loadPlayList() async{
    playList = await ApiService.getAllPlaylist();
    notifyListeners();
  }

  savePlayList(String name) async{
    saveResult = await ApiService.saveNewPlaylist(name);
    notifyListeners();
  }

  removePlayList(int id) async{
    saveResult = await ApiService.removePlaylist(id);
    notifyListeners();
  }
}

class GenreProvider extends ChangeNotifier{

  List<Genre> genreList = [];

  loadGenreList() async{
    genreList = await ApiService.getAllGenres();
    notifyListeners();
  }
}