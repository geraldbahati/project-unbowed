const dbName = 'unbowed.db';
const dbVersion = 1;
const isSynced = 'is_synced';

//-------->message table constants<--------//
const messageTable = 'message';

// message table columns
const messageId = 'id';
const messageDetailUrl = 'message_url';
const messageEditUrl = 'edit_url';
const messageRoom = 'room_id';
const messageSender = 'sender_id';
const messageDescription = 'description';
const messageUpdated = 'updated';
const messageCreated = 'created';

// room table constants
const roomTable = 'room';
const roomId = 'id';
const roomName = 'name';
const roomHost = 'host_id';

// sender table constants
const senderTable = 'sender';
const senderId = 'id';
const senderPhoneNumber = 'phone_number';
const senderUsername = 'username';

// sender table sql
const createSenderTable = '''
CREATE TABLE $senderTable (
  $senderPhoneNumber TEXT PRIMARY KEY,
  $senderUsername TEXT NOT NULL
);
''';

// room table sql
const createRoomTable = '''
CREATE TABLE $roomTable (
  $roomId INTEGER PRIMARY KEY, 
  $roomName TEXT,
  $roomHost TEXT,
  FOREIGN KEY ($roomHost) REFERENCES $senderTable ($senderId)
);
''';

// message table sql
const createMessageTable = '''
CREATE TABLE $messageTable (
  $messageId INTEGER PRIMARY KEY AUTOINCREMENT,
  $messageDetailUrl TEXT NOT NULL,
  $messageEditUrl TEXT NOT NULL,
  $messageDescription TEXT NOT NULL,
  $messageRoom INT NOT NULL,
  $messageSender TEXT NOT NULL,
  $isSynced INTEGER NOT NULL DEFAULT 0,
  $messageUpdated TEXT NOT NULL,
  $messageCreated TEXT NOT NULL,
  FOREIGN KEY ($messageRoom) REFERENCES $roomTable ($roomId),
  FOREIGN KEY ($messageSender) REFERENCES $senderTable ($senderId)

);
''';

//-------->chatroom table constants<--------//
const chatRoomTable = 'chat_room';

// chatroom table columns
const chatRoomId = 'id';
const chatRoomName = 'name';
const chatRoomHost = 'host_id';
const chatRoomDescription = 'description';
const chatRoomUpdated = 'updated';
const chatRoomCreated = 'timestamp';

// participant table constants
const participantTable = 'participant';
const participantId = 'participant_id';
const participantChatRoom = 'chat_room_id';

// chatroom table sql
const createChatRoomTable = '''
CREATE TABLE $chatRoomTable (
  $chatRoomId INTEGER PRIMARY KEY AUTOINCREMENT,
  $chatRoomName TEXT NOT NULL,
  $chatRoomHost TEXT NOT NULL,
  $chatRoomDescription TEXT NOT NULL,
  $isSynced INTEGER NOT NULL DEFAULT 0,
  $chatRoomUpdated TEXT NOT NULL,
  $chatRoomCreated TEXT NOT NULL,
  FOREIGN KEY ($chatRoomHost) REFERENCES $senderTable ($senderId)
);
''';

// participant table sql
const createParticipantTable = '''
CREATE TABLE $participantTable (
  $participantId STRING NOT NULL,
  $participantChatRoom TEXT NOT NULL,
  PRIMARY KEY ($participantId, $participantChatRoom),
  FOREIGN KEY ($participantChatRoom) REFERENCES $chatRoomTable ($chatRoomId),
  FOREIGN KEY ($participantId) REFERENCES $senderTable ($senderId)
);
''';

const dropParticipantTable = '''
DROP TABLE IF EXISTS $participantTable;
''';

const dropChatRoomTable = '''
DROP TABLE IF EXISTS $chatRoomTable;
''';
