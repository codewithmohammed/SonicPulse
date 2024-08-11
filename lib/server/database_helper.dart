import 'package:musicplayer/model/db_song_model.dart';
import 'package:musicplayer/model/music_model.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'music_database.db');
    return await openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, title TEXT, uri TEXT)',
        );
        await db.execute(
          'CREATE TABLE playlists(id INTEGER PRIMARY KEY, name TEXT)',
        );
        await db.execute(
          'CREATE TABLE playlist_songs(id INTEGER PRIMARY KEY, playlist_id INTEGER, song_id INTEGER, title TEXT, uri TEXT, FOREIGN KEY (playlist_id) REFERENCES playlists (id) ON DELETE CASCADE)',
        );
        await db.execute(
          'CREATE TABLE recents(id INTEGER PRIMARY KEY, title TEXT, uri TEXT)',
        );
      },
    );
  }

  Future<void> insertFavorite(Map<String, dynamic> favorite) async {
    final db = await database;
    await db.insert(
      'favorites',
      favorite,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertRecent(Map<String, dynamic> recent) async {
    final db = await database;
    await db.insert(
      'recents',
      recent,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getRecents() async {
    final db = await database;
    return await db.query('recents');
  }

  Future<void> deleteRecent(int id) async {
    final db = await database;
    await db.delete(
      'recents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> createPlaylist(String name) async {
    final db = await database;
    return await db.insert(
      'playlists',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

Future<List<PlaylistsModel>> getPlaylists() async {
  final db = await database; // Assuming you have a database getter function
  final listOfPlaylists = await db.query('playlists'); // Query the 'playlists' table

  // Convert the list of maps to a list of PlaylistsModel
  return List<PlaylistsModel>.from(
    listOfPlaylists.map((playlist) => PlaylistsModel.fromMap(playlist)),
  );
}


  Future<int> updatePlaylist(int id, String newName) async {
    final db = await database;
    return await db.update(
      'playlists',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePlaylist(int id) async {
    final db = await database;
    return await db.delete(
      'playlists',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addSongToPlaylist(int playlistId, DbSongModel dbSongModel) async {
    final db = await database;
    return await db.insert(
        'playlist_songs',
        DbPlaylistModel(
          playlistId: playlistId,
          songId: dbSongModel.id,
          title: dbSongModel.title,
          uri: dbSongModel.uri!,
        ).toJson());
  }

  Future<List<DbPlaylistModel>> getSongsInPlaylist(int playlistId) async {
    final db = await database;

    final playlistSongs = await db.query(
      'playlist_songs',
      where: 'playlist_id = ?',
      whereArgs: [playlistId],
    );

    // Convert the List<Map<String, dynamic>> to List<DbPlaylistModel>
    return playlistSongs.map((song) => DbPlaylistModel.fromJson(song)).toList();
  }

  Future<int> updateSongInPlaylist(
      int id, String newTitle, String newUri) async {
    final db = await database;
    return await db.update(
      'playlist_songs',
      {'title': newTitle, 'uri': newUri},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSongFromPlaylist(int id) async {
    final db = await database;
    return await db.delete(
      'playlist_songs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
