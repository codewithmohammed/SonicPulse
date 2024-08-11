class MusicFolder {
  final String name;
  final String path;
  final List<String> songs;

  MusicFolder({required this.name, required this.path, required this.songs});
}
class PlaylistsModel {
  final int id;
  final String name;

  PlaylistsModel({required this.id, required this.name});

  // Convert a Map to a PlaylistsModel
  factory PlaylistsModel.fromMap(Map<String, dynamic> map) {
    return PlaylistsModel(
      id: map['id'],
      name: map['name'],
    );
  }

  // Convert a PlaylistsModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
