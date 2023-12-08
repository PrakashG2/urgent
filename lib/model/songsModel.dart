class SearchTabCategoryModel {
  final String trackName;
  final int trackId;
  final String url;
  final String artistName;
  final String collectionName;
  String artworkUrl100;


  SearchTabCategoryModel({
    required this.trackName,
    required this.trackId,
    required this.url,
    required this.artistName,
    required this.collectionName,
    required this.artworkUrl100,
  });

  factory SearchTabCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchTabCategoryModel(
      trackName: json['trackName'],
      trackId: json['trackId'],
      url: json['previewUrl'],
      artistName: json['artistName'],
      collectionName: json['collectionName'],
      artworkUrl100: json['artworkUrl100'],
    );
  }
}
