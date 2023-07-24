import 'package:unbowed_flutter/data/models/chatroom/chatroom_model.dart';

import '../constants/db_config.dart';

// List<DatabaseChatRoomModel> dbChatRoomsFromChatRooms(
//     List<ChatroomModel> chatRooms) {
//   return chatRooms.map((chatRoom) {
//     return DatabaseChatRoomModel(
//       id: chatRoom.id,
//       hostId: chatRoom.owner.phoneNumber, // assuming unique phone number
//       name: chatRoom.name,
//       description: chatRoom.description,
//       updated: chatRoom.updated,
//       created: chatRoom.timestamp,
//       isSyncedWithServer: true, // assuming chatRooms from the server are synced
//     );
//   }).toList();
// }

// List<DatabaseParticipantModel> dbParticipantsFromChatRooms(
//     List<ChatroomModel> chatRooms) {
//   var participants = <DatabaseParticipantModel>[];
//   for (var chatRoom in chatRooms) {
//     for (var participantPhoneNumber in chatRoom.participants) {
//       participants.add(DatabaseParticipantModel(
//         id: participantPhoneNumber, // replace with appropriate ID logic
//         chatRoomId: chatRoom.id,
//       ));
//     }
//   }
//   return participants;
// }

List<DatabaseChatRoomModel> dbChatroomsFromChatrooms(
    List<ChatroomModel> chatRooms) {
  return chatRooms.map((chatRoom) {
    var participants = chatRoom.participants.map((participantId) {
      return DatabaseParticipantModel(
        id: participantId, // Assuming the participant id is stored as a String
        chatRoomId: chatRoom.id,
      );
    }).toList();

    return DatabaseChatRoomModel(
      id: chatRoom.id,
      hostId: chatRoom.owner.phoneNumber, // or another unique identifier
      name: chatRoom.name,
      description: chatRoom.description,
      updated: chatRoom.updated,
      created: chatRoom.timestamp,
      isSyncedWithServer: true, // assuming chatRooms from the server are synced
      participants: participants,
    );
  }).toList();
}

List<ChatroomModel> dbChatroomsToChatrooms(
    List<DatabaseChatRoomModel> dbChatRooms) {
  return dbChatRooms.map((dbChatRoom) {
    var participants = dbChatRoom.participants.map((dbParticipant) {
      return dbParticipant.id; // Assuming the participant id is what you want
    }).toList();

    // Assuming Owner object is created from hostId in DatabaseChatRoomModel
    var owner = Owner(
      phoneNumber: dbChatRoom.hostId, // or another unique identifier
      username: "", // username needs to be retrieved from a different source
    );

    return ChatroomModel(
      id: dbChatRoom.id,
      owner: owner,
      participants: participants,
      name: dbChatRoom.name,
      description: dbChatRoom.description,
      lastMessage:
          null, // lastMessage needs to be retrieved from a different source
      updated: dbChatRoom.updated,
      timestamp: dbChatRoom.created,
    );
  }).toList();
}

class DatabaseChatRoomModel {
  final int id;
  final String hostId;
  final String name;
  final String description;
  final DateTime updated;
  final DateTime created;
  final bool isSyncedWithServer;
  final List<DatabaseParticipantModel> participants;

  DatabaseChatRoomModel({
    required this.id,
    required this.hostId,
    required this.name,
    required this.description,
    required this.updated,
    required this.created,
    this.isSyncedWithServer = false,
    required this.participants,
  });

  DatabaseChatRoomModel.fromRow(Map<String, Object?> map,
      List<DatabaseParticipantModel> chatRoomParticipants)
      : id = map[chatRoomId] as int,
        hostId = map[chatRoomHost] as String,
        name = map[chatRoomName] as String,
        description = map[chatRoomDescription] as String,
        updated = DateTime.parse(map[chatRoomUpdated] as String),
        created = DateTime.parse(map[chatRoomCreated] as String),
        isSyncedWithServer = (map[isSynced] as int) == 1,
        participants = chatRoomParticipants;

  Map<String, dynamic> toMap() => {
        chatRoomId: id,
        chatRoomHost: hostId,
        chatRoomName: name,
        chatRoomDescription: description,
        chatRoomUpdated: updated.toIso8601String(),
        chatRoomCreated: created.toIso8601String(),
        isSynced: isSyncedWithServer ? 1 : 0,
      };
}

class DatabaseParticipantModel {
  final String id;
  final int chatRoomId;

  DatabaseParticipantModel({
    required this.id,
    required this.chatRoomId,
  });

  DatabaseParticipantModel.fromRow(Map<String, Object?> map)
      : id = map[participantId] as String,
        chatRoomId = map[participantChatRoom] as int;

  Map<String, dynamic> toMap() => {
        participantId: id,
        participantChatRoom: chatRoomId,
      };
}
