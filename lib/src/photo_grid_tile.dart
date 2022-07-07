import 'package:flutter/material.dart';
import 'package:photo_poc/models/photo.dart';

class PhotoGridTile extends StatelessWidget {
  const PhotoGridTile({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Card(
            child: Image.network(photo.url),
          ),
        ),
        Text(
          photo.album?.title ?? "No Album",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          photo.title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
