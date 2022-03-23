class UrlConfig {

  static const String baseUrl = "http://192.168.60.182:5001";

  static const String registerUrl = "$baseUrl/api/user/newRegister";

  static const String loginUrl = '$baseUrl/api/user/login';

  static const String getUserListUrl = '$baseUrl/api/user/list';

  static const String welcomeUrl = '$baseUrl/api/welcome';

  static const String getArtistListUrl = '$baseUrl/api/list/artists';

  static const String getAllPlaylist = '$baseUrl/api/all/playlists';

  static const String saveNewPlaylist = '$baseUrl/api/new/playlist';

  static const String removePlaylist = '$baseUrl/api/remove/playlist';

  static const String getAllGenres = '$baseUrl/api/all/genres';


}