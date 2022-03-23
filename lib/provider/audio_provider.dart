
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:tai_music/model/song_model.dart';

class AudioProvider extends ChangeNotifier{

  AssetsAudioPlayer player = AssetsAudioPlayer.withId('Playing audio');

  var audios = <Audio>[
    Audio.network(
      'https://cdn.pixabay.com/download/audio/2022/01/20/audio_f1b4f4c8b1.mp3?filename=welcome-to-the-games-15238.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Welcome Here',
        artist: 'Ansh Rathod',
        album: 'OnlineAlbum',
        image: const MetasImage.network(
            'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
      ),
    ),
  ];
  bool isNext = true;

  Future<void> openPlayer(
      {required List<Audio> newlist, int initial = 0}) async {
    await player.open(Playlist(audios: newlist, startIndex: initial),
        showNotification: true,
        autoStart: false,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        notificationSettings: const NotificationSettings(stopEnabled: false));

    notifyListeners();
  }

  void playSong(List<Audio> newPlaylist, int initial) async {
    if (isNext) {
      isNext = false;
      await player.pause();
      await player.stop();
      audios = newPlaylist;
      await openPlayer(newlist: newPlaylist, initial: initial);
      await player.play();
      isNext = true;
    }
  }

  void changeIndex(int newIndex, int oldIndex) {
    player.playlist!.audios
        .insert(newIndex, player.playlist!.audios.removeAt(oldIndex));

    notifyListeners();
  }

  void close() {
    player.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  Audio findByname(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.metas.title == fromPath);
  }

  List<Audio> convertToAudio(List<SongModel> songs) {
    return [
      ...songs.map((audio) {
        return Audio.network(audio.trackid!,
            metas: Metas(
              id: audio.songid,
              title: audio.songname,
              artist: audio.name,
              album: audio.userid,
              image: MetasImage.network(audio.coverImageUrl!),
            ));
      }).toList()
    ];
  }

}