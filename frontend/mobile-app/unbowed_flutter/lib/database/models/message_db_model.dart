import '../../data/models/messages/message_model.dart';
import '../constants/db_config.dart';

List<DatabaseMessageModel> dbMessagesFromMessages(List<Message> messages) {
  return messages.map((message) {
    DatabaseRoomModel room = DatabaseRoomModel(
      id: message.room!.id,
      name: message.room!.name!,
      hostId: message.room!.host!.phoneNumber!, // assuming id is an int
    );

    DatabaseSenderModel sender = DatabaseSenderModel(
      phoneNumber: message.sender!.phoneNumber!,
      username: message.sender!.username!,
    );

    return DatabaseMessageModel(
      id: message.id!,
      messageUrl: message.messageUrl!,
      editUrl: message.editUrl!,
      room: room,
      sender: sender,
      description: message.description!,
      updated: message.updated!,
      created: message.created!,
      isSyncedWithServer: true, // assuming messages from the server are synced
    );
  }).toList();
}

class DatabaseMessageModel {
  final int id;
  final String messageUrl;
  final String editUrl;
  final DatabaseRoomModel room;
  final DatabaseSenderModel sender;
  final String description;
  final DateTime updated;
  final DateTime created;
  final bool isSyncedWithServer;

  DatabaseMessageModel({
    required this.id,
    required this.messageUrl,
    required this.editUrl,
    required this.room,
    required this.sender,
    required this.description,
    required this.updated,
    required this.created,
    this.isSyncedWithServer = false,
  });

  DatabaseMessageModel.fromRow(Map<String, Object?> map)
      : id = map[messageId] as int,
        messageUrl = map[messageDetailUrl] as String,
        editUrl = map[messageEditUrl] as String,
        room = DatabaseRoomModel.fromRow(
            map), // The map should contain the room data
        sender = DatabaseSenderModel.fromRow(
            map), // The map should contain the sender data
        description = map[messageDescription] as String,
        updated = DateTime.parse(map[messageUpdated] as String),
        created = DateTime.parse(map[messageCreated] as String),
        isSyncedWithServer = (map[isSynced] as int) == 1;

  Map<String, dynamic> toMap() {
    return {
      messageId: id,
      messageDetailUrl: messageUrl,
      messageEditUrl: editUrl,
      messageRoom: room.id,
      messageSender: sender.id,
      messageDescription: description,
      messageUpdated: updated.toIso8601String(),
      messageCreated: created.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseMessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseRoomModel {
  final int? id;
  final String name;
  final String hostId; // Foreign key from sender table

  DatabaseRoomModel({
    this.id,
    required this.name,
    required this.hostId,
  });

  DatabaseRoomModel.fromRow(Map<String, dynamic> map)
      : id = map[roomId] as int,
        name = map[roomName] as String,
        hostId = map[roomHost] as String;

  Map<String, dynamic> toMap() {
    return {
      roomName: name,
      roomHost: hostId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseRoomModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseSenderModel {
  final int? id;
  final String phoneNumber;
  final String username;

  DatabaseSenderModel({
    this.id,
    required this.phoneNumber,
    required this.username,
  });

  DatabaseSenderModel.fromRow(Map<String, dynamic> map)
      : id = map[senderId] as int,
        phoneNumber = map[senderPhoneNumber] as String,
        username = map[senderUsername] as String;

  Map<String, dynamic> toMap() {
    return {
      senderPhoneNumber: phoneNumber,
      senderUsername: username,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseSenderModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
