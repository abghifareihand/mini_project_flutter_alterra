import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/models/review_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableFavorite = 'favorites';
  static const String _tableReview = 'reviews';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant.db'),
      //'$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )''');
        await db.execute('''
          CREATE TABLE $_tableReview (
            id INTEGER PRIMARY KEY,
            nameResto TEXT,
            descResto TEXT
          )''');
      },
      version: 1,
    );
    return db;
  }

  //=======================> METHOD FAVORITED <=========================//

  // add favorite
  Future<void> insertFavorite(RestaurantModel restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavorite, restaurant.toJson());
  }

  // menampilkan seluruh data yang sudah di add favorite
  Future<List<RestaurantModel>> getFavorite() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableFavorite);

    return results.map((res) => RestaurantModel.fromJson(res)).toList();
  }

  // mengambil data dengan id
  Future<Map> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  // fungsi menghapus data favorite
  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //=====================================================================//

  //=======================> METHOD REVIEW FORM <=========================//

  Future<void> insertReview(ReviewModel review) async {
    final Database db = await database;
    await db.insert(_tableReview, review.toMap());
  }

  // metode untuk menampilkan seluruh note yang disimpan dalam database.
  Future<List<ReviewModel>> getReview() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableReview);

    return results.map((res) => ReviewModel.fromMap(res)).toList();
  }

  // metode mengambil data dengan id tertentu
  Future<ReviewModel> getReviewById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableReview,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => ReviewModel.fromMap(res)).first;
  }

  // metode untuk memperbarui data
  Future<void> updateReview(ReviewModel review) async {
    final db = await database;

    await db.update(
      _tableReview,
      review.toMap(),
      where: 'id = ?',
      whereArgs: [review.id],
    );
  }

  // metode untuk menghapus data
  Future<void> deleteReview(int id) async {
    final db = await database;

    await db.delete(
      _tableReview,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //======================================================================//
}
