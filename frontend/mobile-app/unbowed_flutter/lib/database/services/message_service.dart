import 'dart:async';

import '../constants/db_config.dart';
import '../models/message_db_model.dart';
import 'db_service.dart';

class MessageDbService {
  final DatabaseService _dbService = DatabaseService();
  late final StreamController<List<DatabaseMessageModel>>
      _messagesStreamController;
  List<DatabaseMessageModel> _messages = [];

  static final MessageDbService _instance = MessageDbService._internal();

  MessageDbService._internal() {
    _messagesStreamController =
        StreamController<List<DatabaseMessageModel>>.broadcast(
      onListen: () {
        _messagesStreamController.sink.add(_messages);
      },
    );
  }

  factory MessageDbService() => _instance;

  Future<void> init() async {
    final dbClient = await _dbService.db;
    final tables = await dbClient.query('sqlite_master');
    final tableNames = tables.map((table) => table['name'] as String).toList();
    if (!tableNames.contains(messageTable)) {
      await dbClient.execute(createMessageTable);
    }
    await _cacheMessages();
  }

  Future<void> deleteAllMessages() async {
    final dbClient = await _dbService.db;
    await dbClient.delete(messageTable);
    await _cacheMessages();
  }

  Stream<List<DatabaseMessageModel>> get messagesStream =>
      _messagesStreamController.stream;

  Future<void> saveAllMessages(
      {required List<DatabaseMessageModel> messages}) async {
    final dbClient = await _dbService.db;
    final batch = dbClient.batch();
    for (DatabaseMessageModel message in messages) {
      batch.insert(messageTable, message.toMap());
    }
    await batch.commit();
    await _cacheMessages();
  }

  Future<int> saveMessage({required DatabaseMessageModel message}) async {
    final dbClient = await _dbService.db;
    final id = await dbClient.insert(messageTable, message.toMap());
    await _cacheMessages();
    return id;
  }

  Future<void> updateMessage({required DatabaseMessageModel message}) async {
    final dbClient = await _dbService.db;
    await dbClient.update(
      messageTable,
      message.toMap(),
      where: '$messageId = ?',
      whereArgs: [message.id],
    );
    await _cacheMessages();
  }

  Future<void> deleteMessage({required int messageId}) async {
    final dbClient = await _dbService.db;
    await dbClient.delete(
      messageTable,
      where: '$messageId = ?',
      whereArgs: [messageId],
    );
    await _cacheMessages();
  }

  // Future<void> syncMessages() {
  //   List<DatabaseMessageModel> unsyncedMessages =
  //       _messages.where((message) => !message.isSyncedWithServer).toList();

  // }

  Future<Iterable<DatabaseMessageModel>> getAllMessages(int chatRoomId) async {
    final dbClient = await _dbService.db;
    final messages = await dbClient.query(messageTable);
    return messages
        .map((message) => DatabaseMessageModel.fromRow(message))
        .where((message) => message.room.id == chatRoomId);
  }

  Future<void> _cacheMessages() async {
    final allMessages = await getAllMessages();
    _messages = allMessages.toList();
    _messagesStreamController.add(_messages);
  }

  Future<void> close() async {
    await _messagesStreamController.close();
  }
}
