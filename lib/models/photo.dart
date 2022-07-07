import 'package:photo_poc/models/album.dart';

class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;
  Album? album;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    this.album
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var albumId = json["albumId"];
    var title = json["title"];
    var url = json["url"];
    var thumbnailUrl = json["thumbnailUrl"];

    return Photo(id: id, albumId: albumId, title: title, url: url, thumbnailUrl: thumbnailUrl);
  }

  @override
  String toString() {
    return """{
      id: $id
      album: $album
      title: $title
      url: $url
      thumbnailUrl: $thumbnailUrl
    }""";
  }
}
