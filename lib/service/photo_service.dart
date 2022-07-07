import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_poc/models/album.dart';
import 'package:photo_poc/models/photo.dart';

class PhotoService {
  final _albumUrl = "https://www.scalablepath.com/api/test/test-albums-real";
  final _photoUrl = "https://www.scalablepath.com/api/test/test-photos-real";

  Future<List<Photo>> fetchData() async {
    var photos = await _fetchPhotos();
    var albuns = await _fetchAlbum();

    for (var photo in photos) {
      photo.album = albuns.firstWhere((album) => album.id == photo.albumId);
    }

    return photos;
  }

  Future<List<Photo>> _fetchPhotos() async {
    var response = await http.get(Uri.parse(_photoUrl));
    if(response.statusCode == 200) {
      List json = jsonDecode(response.body);
      
      return json.map((e) => Photo.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Album>> _fetchAlbum() async {
    var response = await http.get(Uri.parse(_albumUrl));
    if(response.statusCode == 200) {
      List json = jsonDecode(response.body);
      
      return json.map((e) => Album.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}