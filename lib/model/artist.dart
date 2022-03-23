class Artist{
  late final int artistId;
  late final String artistName;
  late final String artistProfile;
  late final int rankOrder;

  Artist(this.artistId, this.artistName, this.artistProfile);

  Artist.fromJson(Map<String, dynamic> data) {
    artistId = data['artistId'];
    artistName = data['artistName'];
    artistProfile = data['artistProfile'];
    rankOrder = data['rankOrder'];
  }

  Map<String, dynamic> toMap() {
    return {
      'artistId': artistId,
      'artistName': artistName,
      'artistProfile': artistProfile,
      'rankOrder': rankOrder,
    };
  }
}