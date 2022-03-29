class SongModel {
  late String? songid;
  late String? songname;
  late String? userid;
  late String? trackid;
  late String? duration;
  late String? coverImageUrl;
  late String? name;

  SongModel(
    this.songid,
    this.songname,
    this.userid,
    this.trackid,
    this.duration,
    this.coverImageUrl,
    this.name,
  );

  /*factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        songid: json['songid'] as String?,
        songname: json['songname'] as String?,
        userid: json['userid'] as String?,
        trackid: json['trackid'] as String?,
        duration: json['duration'] as String?,
        coverImageUrl: json['cover_image_url'] as String?,
        name: json['first_name'] + ' ' + json['last_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'songid': songid,
        'songname': songname,
        'userid': userid,
        'trackid': trackid,
        'duration': duration,
        'cover_image_url': coverImageUrl,
      };*/
}
