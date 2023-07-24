import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unbowed_flutter/database/constants/db_config.dart';
import 'package:unbowed_flutter/database/services/exceptions.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _db;

  DatabaseService._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    if (_db != null) throw DatabaseAlreadyOpenException();
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);

      return await openDatabase(dbPath,
          version: dbVersion, onCreate: _onCreate);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentDirectoryException();
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(createSenderTable);
    await db.execute(createRoomTable);
    await db.execute(createMessageTable);
    await db.execute(createChatRoomTable);
    await db.execute(createParticipantTable);
  }

  Future<int> saveItem(String table, Map<String, dynamic> item) async {
    final dbClient = await db;
    return await dbClient.insert(table, item);
  }

  Future<List<Map<String, dynamic>>> getAllItems(String table) async {
    final dbClient = await db;
    return await dbClient.query(table);
  }

  Future<List<Map<String, dynamic>>> getItemsByColumn(
      String table, String column, String value) async {
    final dbClient = await db;
    return await dbClient
        .query(table, where: '$column = ?', whereArgs: [value]);
  }

  Future<void> deleteAllItems(String table) async {
    final dbClient = await db;
    await dbClient.delete(table);
  }

  Future<void> deleteDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, dbName);
    await deleteDatabase(dbPath);
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      return;
    }

    throw DatabaseIsNotOpenException();
  }
}
