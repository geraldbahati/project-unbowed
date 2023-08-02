class DatabaseIsNotOpenException implements Exception {}

class DatabaseAlreadyOpenException implements Exception {}

class UnableToGetDocumentDirectoryException implements Exception {}

// Custom exceptions
class SaveChatRoomException implements Exception {
  final String cause;
  SaveChatRoomException(this.cause);
}

class UpdateChatRoomException implements Exception {
  final String cause;
  UpdateChatRoomException(this.cause);
}

class DeleteChatRoomException implements Exception {
  final String cause;
  DeleteChatRoomException(this.cause);
}

class SaveAllChatRoomsException implements Exception {
  final String cause;
  SaveAllChatRoomsException(this.cause);
}

class DeleteAllChatRoomsException implements Exception {
  final String cause;
  DeleteAllChatRoomsException(this.cause);
}

class DeleteParticipantException implements Exception {
  final String cause;
  DeleteParticipantException(this.cause);
}

class GetAllChatRoomsException implements Exception {
  final String cause;
  GetAllChatRoomsException(this.cause);
}

class CacheChatRoomsException implements Exception {
  final String cause;
  CacheChatRoomsException(this.cause);
}
