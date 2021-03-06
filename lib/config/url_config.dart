class UrlConfig {

  static const String baseUrl = "http://192.168.60.183:3000";

  //using mysql local

  static const String registerUrl = "$baseUrl/api/user/newRegister";

  static const String loginUrl = '$baseUrl/api/user/login';

  static const String getUserListUrl = '$baseUrl/api/user/list';

  static const String welcomeUrl = '$baseUrl/api/welcome';

  static const String getArtistListUrl = '$baseUrl/api/list/artists';

  static const String getAllPlaylist = '$baseUrl/api/all/playlists';

  static const String saveNewPlaylist = '$baseUrl/api/new/playlist';

  static const String removePlaylist = '$baseUrl/api/remove/playlist';

  static const String getAllGenres = '$baseUrl/api/all/genres';

  //using mongo
  static const String mongoGetArtistList = '$baseUrl/api/mongo/list/artist';

  static const String mongoGetAllPlaylist = '$baseUrl/api/mongo/list/playlist';

  static const String mongoGetAllGenre = '$baseUrl/api/mongo/list/genre';

  static const String imageUploadBase64 = '$baseUrl/image/base64';

  static const String imageUploadNormal = '$baseUrl/upload';

  static const String imageUploadCloud = '$baseUrl/image/upload';


}