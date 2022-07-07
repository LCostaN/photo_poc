class Album {
  final String title;
  final int id;

  Album({required this.title, required this.id});

  factory Album.fromJson(Map<String, dynamic> json) {
    var title = json["title"];
    var id = json["id"];
    
    return Album(title: title, id: id);
  }

  @override
  String toString() {
    return "{ id: $id,  title: $title}";
  }
}