class Genre{
  late int genreId;
  late String genreName;
  late String genreProfile;
  late int rankOrder;

  Genre(this.genreId, this.genreName, this.genreProfile, this.rankOrder);

  Genre.fromJson(Map<dynamic, dynamic> json){
    genreId = json['genreId'];
    genreName = json['genreName'];
    genreProfile = json['genreProfile'];
    rankOrder = json['rankOrder'];
  }
}