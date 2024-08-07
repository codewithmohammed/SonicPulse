class DbSongModel {
  final String id;
  final String title;
  final String url;
  DbSongModel({required this.id, required this.title, required this.url});

  factory DbSongModel.fromJson(Map<String, dynamic> json) {
    return DbSongModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }
}
