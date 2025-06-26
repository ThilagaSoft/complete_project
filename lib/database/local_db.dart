import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:map_pro/model/user_model.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._privateConstructor();
  static LocalDatabase get instance => _instance;

  static Database? _database;

  LocalDatabase._privateConstructor();

  /// Ensure the database is initialized and opened
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  /// Initialize and open the database, handle onCreate and onUpgrade
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return await openDatabase(
      path,
      version: 2, // ⬅️ Increment version to trigger upgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Called only once when the DB is first created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT NOT NULL,
        mobile TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        countryData TEXT NOT NULL
      )
    ''');
  }

  /// Called when database version increases
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN countryData TEXT NOT NULL DEFAULT ""');
    }
  }

  /// Insert a new user model
  Future<int> insertUserModel(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  /// Get a user by email
  Future<UserModel?> getUserModelByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  /// Get a user by ID
  Future<UserModel?> getUserModelById(int id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  /// Get all users in the DB
  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final maps = await db.query('users');

    return maps.map((map) => UserModel.fromJson(map)).toList();
  }
}
