import 'dart:async';

import 'package:unbowed_flutter/database/services/db_service.dart';

import '../constants/db_config.dart';
import '../models/chatroom_db_model.dart';

class ChatroomDbService {
  final DatabaseService _dbService = DatabaseService();
  late final StreamController<List<DatabaseChatRoomModel>>
      _chatRoomsStreamController;

  List<DatabaseChatRoomModel> _chatRooms = [];

  static final ChatroomDbService _instance = ChatroomDbService._internal();

  ChatroomDbService._internal() {
    _chatRoomsStreamController =
        StreamController<List<DatabaseChatRoomModel>>.broadcast(
      onListen: () {
        _chatRoomsStreamController.sink.add(_chatRooms);
      },
    );
  }

  int counter = 0;

  factory ChatroomDbService() => _instance;

  Future<void> init() async {
    final dbClient = await _dbService.db;
    final tables = await dbClient.query('sqlite_master');
    final tableNames = tables.map((table) => table['name'] as String).toList();

    if (!tableNames.contains(chatRoomTable)) {
      await dbClient.execute(createChatRoomTable);
    }
    if (!tableNames.contains(participantTable)) {
      await dbClient.execute(createParticipantTable);
    }
    await _cacheChatRooms();
  }

  Future<void> deleteAllChatRooms() async {
    final dbClient = await _dbService.db;
    await dbClient.delete(chatRoomTable);
    await dbClient.delete(participantTable);
    await _cacheChatRooms();
  }

  Stream<List<DatabaseChatRoomModel>> get chatRoomsStream =>
      _chatRoomsStreamController.stream;

  Future<int> saveChatRoom({required DatabaseChatRoomModel chatRoom}) async {
    final dbClient = await _dbService.db;
    final id = await dbClient.insert(chatRoomTable, chatRoom.toMap());
    await _cacheChatRooms();
    return id;
  }

  Future<void> updateChatRoom({required DatabaseChatRoomModel chatRoom}) async {
    final dbClient = await _dbService.db;
    await dbClient.update(
      chatRoomTable,
      chatRoom.toMap(),
      where: '$chatRoomId = ?',
      whereArgs: [chatRoom.id],
    );
    await _cacheChatRooms();
  }

  Future<Iterable<DatabaseChatRoomModel>> getAllChatRooms() async {
    final dbClient = await _dbService.db;
    final chatRooms = await dbClient.query(chatRoomTable);
    final participants = await dbClient.query(participantTable);
    return chatRooms.map((chatRoom) {
      final participantIds = participants
          .where((participant) =>
              participant[participantId] == chatRoom[chatRoomId])
          .map((participant) => DatabaseParticipantModel.fromRow(participant))
          .toList();
      return DatabaseChatRoomModel.fromRow(chatRoom, participantIds);
    }).toList();
  }

  Future<void> _cacheChatRooms() async {
    final allChatRooms = await getAllChatRooms();
    _chatRooms = allChatRooms.toList();
    _chatRoomsStreamController.add(_chatRooms);
  }

  Future<void> close() async {
    await _chatRoomsStreamController.close();
  }

  Future<void> deleteChatRoom({required int chatRoomId}) async {
    final dbClient = await _dbService.db;
    await dbClient.delete(
      chatRoomTable,
      where: '$chatRoomId = ?',
      whereArgs: [chatRoomId],
    );
    await _cacheChatRooms();
  }

  Future<void> deleteParticipant({required int participantId}) async {
    final dbClient = await _dbService.db;
    await dbClient.delete(
      participantTable,
      where: '$participantId = ?',
      whereArgs: [participantId],
    );
    await _cacheChatRooms();
  }

  Future<void> deleteAllParticipants() async {
    final dbClient = await _dbService.db;
    await dbClient.delete(participantTable);
    await _cacheChatRooms();
  }

  Future<void> saveAllChatRooms(
      {required List<DatabaseChatRoomModel> chatRooms}) async {
    final dbClient = await _dbService.db;

    for (var chatRoom in chatRooms) {
      await dbClient.insert(chatRoomTable, chatRoom.toMap());
      for (var participant in chatRoom.participants) {
        counter++;
        print("counter: $counter");
        await dbClient.insert(participantTable, participant.toMap());
      }
    }
    await _cacheChatRooms();
  }

  Future<void> deleteChatRoomAndParticipantTables() async {
    final dbClient = await _dbService.db;
    await dbClient.execute(dropChatRoomTable);
    await dbClient.execute(dropParticipantTable);
    await _cacheChatRooms();
  }
}
