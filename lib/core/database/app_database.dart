import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// SQLite Database manager for Wirdi (وِردي).
///
/// Implements offline-first persistent storage foundation.
/// Specific tables (Quran, Wird, Memorization, Revision, Adhkar)
/// will be created via versioned migrations in subsequent steps.
class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'wirdi.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Foundation established: Tables will be added once approved schemas are ready.
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration hooks for future database versions
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
