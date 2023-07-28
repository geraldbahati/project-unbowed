import 'dart:async';

import 'package:unbowed_flutter/database/services/db_service.dart';
import 'package:unbowed_flutter/database/services/exceptions.dart';

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

  factory ChatroomDbService() => _instance;

  // Initialization and Stream management
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

  Stream<List<DatabaseChatRoomModel>> get chatRoomsStream =>
      _chatRoomsStreamController.stream;

  Future<void> close() async {
    await _chatRoomsStreamController.close();
  }

  // Chat Room operations
  Future<int> saveChatRoom({required DatabaseChatRoomModel chatRoom}) async {
    final dbClient = await _dbService.db;
    try {
      final id = await dbClient.insert(chatRoomTable, chatRoom.toMap());
      await _cacheChatRooms();
      return id;
    } catch (e) {
      throw SaveChatRoomException(e.toString());
    }
  }

  Future<void> updateChatRoom({required DatabaseChatRoomModel chatRoom}) async {
    final dbClient = await _dbService.db;
    try {
      await dbClient.update(
        chatRoomTable,
        chatRoom.toMap(),
        where: '$chatRoomId = ?',
        whereArgs: [chatRoom.id],
      );
      await _cacheChatRooms();
    } catch (e) {
      throw UpdateChatRoomException(e.toString());
    }
  }

  Future<void> deleteChatRoom({required int chatRoomId}) async {
    final dbClient = await _dbService.db;
    try {
      await dbClient.delete(
        chatRoomTable,
        where: '$chatRoomId = ?',
        whereArgs: [chatRoomId],
      );
      await _cacheChatRooms();
    } catch (e) {
      throw DeleteChatRoomException(e.toString());
    }
  }

  // Participant operations
  Future<void> deleteParticipant({required int participantId}) async {
    final dbClient = await _dbService.db;
    try {
      await dbClient.delete(
        participantTable,
        where: '$participantId = ?',
        whereArgs: [participantId],
      );
      await _cacheChatRooms();
    } catch (e) {
      throw DeleteParticipantException(e.toString());
    }
  }

  // Compound operations
  Future<void> saveAllChatRooms(
      {required List<DatabaseChatRoomModel> chatRooms}) async {
    final dbClient = await _dbService.db;

    try {
      await deleteAllChatRooms();

      for (var chatRoom in chatRooms) {
        await dbClient.insert(chatRoomTable, chatRoom.toMap());
        for (var participant in chatRoom.participants) {
          await dbClient.insert(participantTable, participant.toMap());
        }
      }
      await _cacheChatRooms();
    } catch (e) {
      throw SaveAllChatRoomsException(e.toString());
    }
  }

  Future<void> deleteAllChatRooms() async {
    final dbClient = await _dbService.db;
    try {
      await dbClient.delete(chatRoomTable);
      await dbClient.delete(participantTable);
      await _cacheChatRooms();
    } catch (e) {
      throw DeleteAllChatRoomsException(e.toString());
    }
  }

  // Utilities
  Future<Iterable<DatabaseChatRoomModel>> getAllChatRooms() async {
    final dbClient = await _dbService.db;
    try {
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
    } catch (e) {
      throw GetAllChatRoomsException(e.toString());
    }
  }

  Future<void> _cacheChatRooms() async {
    try {
      final allChatRooms = await getAllChatRooms();
      _chatRooms = allChatRooms.toList();
      _chatRoomsStreamController.add(_chatRooms);
    } catch (e) {
      throw CacheChatRoomsException(e.toString());
    }
  }
}
